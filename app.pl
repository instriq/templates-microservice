#!/usr/bin/env perl

use 5.030;
use utf8;
use strict;
use warnings;
use YAML::XS;
use Mojolicious::Lite;
use Mojo::JSON qw(decode_json);

our $VERSION = "0.0.1";

plugin "I18N" => { namespace => "VulnTemplates" };

get "/" => sub {
    my $self   = shift;
    my $lang   = $self -> param("lang") || "en";
    my $id     = $self -> param("id");
    my $result = [];

    my $yaml  = YAML::XS::LoadFile("./templates/index.yml");
    my $files = $yaml -> {"index"};

    foreach my $hash (@$files) {
        foreach my $key (keys %$hash) {
            my $value = $hash -> {$key};
            my $load  = YAML::XS::LoadFile("./templates/$value.yml");

            if ($load) {
                my $template = $load -> {"vulnerability"};
                
                my $item = {
                    "id"             => $key,
                    "name"           => $template -> {"name"} -> {$lang},
                    "type"           => $template -> {"type"},
                    "category"       => $template -> {"category"},
                    "description"    => $template -> {"description"} -> {$lang},
                    "recommendation" => $template -> {"recommendation"} -> {$lang},
                    "references"     => $template -> {"references"}
                };

                push @$result, $item;
            }
        }
    }

    if ($id) {
        foreach my $vuln (@$result) {
            if ($vuln -> {"id"} == $id) {
                $result = $vuln;
                
                return $self -> render (
                    status => 200,
                    json => { "templates" => $result }
                );
            }
        }

        return $self -> render (
            status => 404,
            json => { "error" => "Template not found" }
        );
    }
    
    return $self -> render (
        status => 200,
        json => { "templates" => $result }
    );
};

app -> hook(
    after_render => sub {
        my ($self, $output, $format) = @_;

        $self -> res ->headers -> header("Content-Security-Policy" => "default-src \"self\"");
        $self -> res ->headers -> header("X-Content-Type-Options" => "nosniff");
        $self -> res ->headers -> header("X-Frame-Options" => "DENY");
        $self -> res ->headers -> header("Strict-Transport-Security" => "max-age=31536000; includeSubDomains");
        $self -> res ->headers -> content_type("application/json");
    }
);

app -> hook(
    before_dispatch => sub {
        my $cors = shift;

        $cors -> res -> headers -> header("Access-Control-Allow-Origin" => "*");
        $cors -> res -> headers -> header("Access-Control-Allow-Methods" => "GET, OPTIONS");
        $cors -> res -> headers -> header("Access-Control-Allow-Headers" => "Origin, Content-Type, Accept");
        $cors -> res -> headers -> header("Access-Control-Max-Age" => "86400");
    }
);

app -> start();