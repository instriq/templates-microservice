#!/usr/bin/env perl

use 5.030;
use utf8;
use strict;
use warnings;
use YAML::XS;
use Mojolicious::Lite;
use Mojo::JSON qw(decode_json);

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
                
                return $self -> render(json => { "templates" => $result });
            }
        }

        return $self -> render(
            status => 404,
            json => { "Error" => "Template not found" }
        );
    }
    
    return $self -> render (json => { "templates" => $result });
};

app -> start();