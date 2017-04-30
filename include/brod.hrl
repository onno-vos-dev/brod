%%%
%%%   Copyright (c) 2014-2016, Klarna AB
%%%
%%%   Licensed under the Apache License, Version 2.0 (the "License");
%%%   you may not use this file except in compliance with the License.
%%%   You may obtain a copy of the License at
%%%
%%%       http://www.apache.org/licenses/LICENSE-2.0
%%%
%%%   Unless required by applicable law or agreed to in writing, software
%%%   distributed under the License is distributed on an "AS IS" BASIS,
%%%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%%%   See the License for the specific language governing permissions and
%%%   limitations under the License.
%%%

-ifndef(__BROD_HRL).
-define(__BROD_HRL, true).

-type kafka_key()                 :: brod:kafka_key().
-type kafka_value()               :: brod:kafka_value().
-type kafka_kv_list()             :: brod:kafka_kv_list().
-type kafka_topic()               :: brod:kafka_topic().
-type kafka_partition()           :: brod:kafka_partition().
-type kafka_offset()              :: brod:kafka_offset().
-type kafka_error_code()          :: brod:kafka_error_code().
-type kafka_group_id()            :: brod:kafka_group_id().
-type kafka_group_member_id()     :: brod:kafka_group_member_id().
-type kafka_group_generation_id() :: brod:kafka_group_generation_id().
-type kafka_compression()         :: brod:kafka_compression().
-type brod_client_id()            :: brod:brod_client_id().

-record(kafka_message,
        { offset     :: brod:kafka_offset()
        , magic_byte :: integer()
        , attributes :: integer()
        , key        :: binary()
        , value      :: binary()
        , crc        :: integer()
        }).

-type kafka_message() :: brod:kafka_message().

-record(kafka_message_set,
        { topic          :: brod:kafka_topic()
        , partition      :: brod:kafka_partition()
        , high_wm_offset :: integer() %% max offset of the partition
        , messages       :: kpro:incomplete_message() | [brod:kafka_message()]
        }).

-record(kafka_fetch_error,
        { topic      :: brod:kafka_topic()
        , partition  :: brod:kafka_partition()
        , error_code :: brod:kafka_error_code()
        , error_desc :: binary()
        }).

-define(BROD_DEFAULT_CLIENT_ID, brod_default_client).

-record(brod_call_ref, { caller :: pid()
                       , callee :: pid()
                       , ref    :: reference()
                       }).

-type brod_call_ref() :: brod:call_ref().
-type brod_produce_result() :: brod:produce_result().

-record(brod_produce_reply, { call_ref :: brod:call_ref()
                            , result   :: brod:produce_result()
                            }).

-type brod_produce_reply() :: brod:produce_reply().

-type brod_client_config() :: brod:client_config().
-type brod_producer_config() :: brod:producer_config().
-type brod_consumer_config() :: brod:consumer_config().
-type brod_group_config() :: brod:group_config().
-type brod_offset_commit_policy() :: brod:offset_commit_policy().
-type brod_partition_assignment_strategy() :: brod:partition_assignment_strategy().

-record(kafka_group_member_metadata,
        { version   :: non_neg_integer()
        , topics    :: [brod:kafka_topic()]
        , user_data :: binary()
        }).

-type kafka_group_member() :: brod:kafka_group_member().

-type brod_partition_assignment() :: brod:partition_assignment().

-record(brod_received_assignment,
        { topic        :: brod:kafka_topic()
        , partition    :: brod:kafka_partition()
        , begin_offset :: undefined | brod:kafka_offset()
        }).

-type brod_received_assignments() :: brod:received_assignments().

-define(BROD_CONSUMER_GROUP_PROTOCOL_VERSION, 0).

-type brod_partition_fun() :: brod:partition_fun().

-endif. % include brod.hrl

%%% Local Variables:
%%% erlang-indent-level: 2
%%% End:
