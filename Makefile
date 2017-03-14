PROJECT = brod
PROJECT_DESCRIPTION = Kafka client library in Erlang
PROJECT_VERSION = 2.2.15

DEPS = supervisor3 kafka_protocol
dep_supervisor3 = git https://github.com/klarna/supervisor3.git 1.1.5
dep_kafka_protocol = git https://github.com/klarna/kafka_protocol.git hakaton_walrus_compatibility

TEST_DEPS = meck proper

COVER = true

EUNIT_OPTS = verbose
ERLC_OPTS = -Werror +warn_unused_vars +warn_shadow_vars +warn_unused_import +warn_obsolete_guard +debug_info
CT_OPTS = -ct_use_short_names true

include erlang.mk

ERL_LIBS := $(ERL_LIBS):$(CURDIR)

test-env:
	./scripts/setup-test-env.sh

t: eunit ct
	./scripts/cover-summary.escript eunit.coverdata ct.coverdata

vsn-check:
	$(verbose) ./scripts/vsn-check.sh $(PROJECT_VERSION)

ESCRIPT_FILE = scripts/$(PROJECT)

hex-publish: distclean
	$(verbose) rebar3 hex publish

