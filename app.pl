#!/usr/bin/env perl

use 5.018;
use utf8;
use strict;
use warnings;
use YAML::XS;
use Mojolicious::Lite;
use Mojo::JSON qw(decode_json);

plugin "I18N" => { namespace => "VulnTemplates" };

get "/templates" => sub {
    my $self   = shift;
    my $lang   = $self -> param("lang") || "en";
    my $id     = $self -> param("id");
    my $result = [];

    my $yaml  = YAML::XS::LoadFile("vulnerability-templates/files.yml");
    my $files = $yaml -> {"files"};

    foreach my $hash (@$files) {
        foreach my $key (keys %$hash) {
            my $value = $hash -> {$key};
            my $load  = YAML::XS::LoadFile("vulnerability-templates/$value.yml");

            if ($load) {
                my $template = $load -> {"vulnerability"};
                
                my $item = {
                    "id"             => $key,
                    "name"           => $template -> {"name"},
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
                last;
            }
        }

        return $self -> render(json => { "templates" => $result });
    }
    
    return $self -> render (json => { "templates" => $result });
};

app -> start();