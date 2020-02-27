Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4C517295D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 21:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgB0URD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 15:17:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54489 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729912AbgB0URC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 15:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582834621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3fOJHSnsK8bUUX0O9aiDaelyxxWkIjoiY1G8Lg+S74=;
        b=giQQ8h86nJM4j51TFDC8lSe8F9b0Bo1tKCZZCUHkXuWqr/L5mj7LUPPrcs1teVatlUtfTL
        xS8Bff+rs6xiY+Qx1vgcZZpWo7H+4S/8AHu6NODuYLRQKe6NuVEF0aFU0toKFFhqlOknWU
        /migx7lJlTYBsP+RpJrIkI6klQTvSOA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-FP9Q41QgOXOrvmlY7xw_Og-1; Thu, 27 Feb 2020 15:16:49 -0500
X-MC-Unique: FP9Q41QgOXOrvmlY7xw_Og-1
Received: by mail-wr1-f69.google.com with SMTP id l1so319565wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 12:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y3fOJHSnsK8bUUX0O9aiDaelyxxWkIjoiY1G8Lg+S74=;
        b=lOVvR/CN1+1n2fDGHmIVdUWP2NEv4oSv60iVmIsPdJ4dlk/+MRYImz4aArP5Ru83Wu
         G76NOQiU3pHP2OdlW+6qCJUZLLIrs8PNXt5FC/JK/R7c2trr5S7Gk9x/kBqcCQZSfmaS
         56p72j0676o8ylIM1FFvMi7v0vKxuCG+LxurLXbrzGoIKTOGrdXO7eIumTOGFOMHnkFD
         tez6OGNya+loqjjQGfcIcF4E6RfrvfYlDTPTmYk2M9OD9WtnqIE49rx0CDDhC/57g1mS
         O967vcmA0MWJwTX+c5oJCYRCVPGqQubLDGUsl9JrkTmQe+MxEXzqLNjzq1/jg4vdOVHc
         PuYw==
X-Gm-Message-State: APjAAAU9aYsTLXZhr1szlbmF6rU9HKPnkAv/8nFuumuC4ZPpluBQ1fAJ
        R20FhreLCh65UaO3e8+SCI4FmjQn+w8yNdkmDhJMKvaNE8USWLFFyKlfr8r29oc8hgo+LZt0kJ4
        pAzk7nX7+uGVm9v4xbCV6/EMm
X-Received: by 2002:a7b:c2a2:: with SMTP id c2mr468136wmk.19.1582834608163;
        Thu, 27 Feb 2020 12:16:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqz2JS2h4znC0KUz06xftudJ8eHC57tOGSIjXU0cOvfqAreGDq0pGhC2ptjAXhG5tbsIWi9/Jg==
X-Received: by 2002:a7b:c2a2:: with SMTP id c2mr468121wmk.19.1582834607840;
        Thu, 27 Feb 2020 12:16:47 -0800 (PST)
Received: from ?IPv6:2a02:8388:7c1:1280:a281:9dab:554b:2fdc? (2a02-8388-07c1-1280-a281-9dab-554b-2fdc.cable.dynamic.v6.surfer.at. [2a02:8388:7c1:1280:a281:9dab:554b:2fdc])
        by smtp.gmail.com with ESMTPSA id t10sm9320485wru.59.2020.02.27.12.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 12:16:46 -0800 (PST)
Subject: Re: [RFC] perf script: add flamegraph.py script
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kabbott@redhat.com,
        skozina@redhat.com, mpetlan@redhat.com, nathans@redhat.com,
        mgoodwin@redhat.com, linux-perf-users@vger.kernel.org,
        bgregg@netflix.com, mspier@netflix.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <20200221175500.83774-1-agerstmayr@redhat.com>
 <20200225195418.GA160300@krava>
 <0582d729-0e07-b95d-7cad-8912514b8871@redhat.com>
 <20200225202056.GA160294@krava>
 <cd44bf7a-6766-d42b-50d1-482d389fe488@redhat.com>
Message-ID: <47ffe459-0920-60d0-b6b0-d7cebb77448b@redhat.com>
Date:   Thu, 27 Feb 2020 21:16:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cd44bf7a-6766-d42b-50d1-482d389fe488@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.02.20 21:36, Andreas Gerstmayr wrote:
> On 25.02.20 21:20, Jiri Olsa wrote:
>> On Tue, Feb 25, 2020 at 09:03:19PM +0100, Andreas Gerstmayr wrote:
>>> On 25.02.20 20:54, Jiri Olsa wrote:
>>>> On Fri, Feb 21, 2020 at 06:55:01PM +0100, Andreas Gerstmayr wrote:
>>>>> Usage:
>>>>>
>>>>>       perf script flamegraph -a -F 99 sleep 60
>>>>>
>>>>> Alternative usage:
>>>>>
>>>>>       perf record -a -g -F 99 sleep 60
>>>>>       perf script report flamegraph
>>>>
>>>> nice, could this output the output file, like:
>>>>
>>>>        # perf script report flamegraph --output krava.html
>>>>        dumping data to krava.html
>>
>> I meant the actual line ^^^^, saying that it's writing to the file
> 
> Ah! Sorry, I misunderstood.
> Yep, sure, I can add that.
> 
> I also have one other change lined up to reduce the JSON output, and I'm 
> testing it with huge flamegraphs right now. Will send an update this week.

Ok, I'll need some more time to properly test this with huge flame 
graphs and different browsers. I'll get back to this in ~2 weeks after 
my PTO.


Cheers,
Andreas


> 
> 
> Cheers,
> Andreas
> 
> 
>>
>> thanks,
>> jirka
>>
>>>>
>>>> or something in that sense
>>>>
>>>> other than that it looks good to me
>>>
>>> Yes, it's already implemented.
>>>
>>> $ perf script report flamegraph --output krava.html
>>>
>>> writes the output to krava.html
>>>
>>> $ perf script report flamegraph --help
>>>
>>> shows the supported arguments.
>>>
>>> The only gotcha is that you need to have a perf.data in the same 
>>> directory
>>> when calling this command, otherwise perf complains about a missing
>>> perf.data and doesn't call the flamegraph.py script.
>>>
>>>
>>> Cheers,
>>> Andreas
>>>
>>>
>>>>
>>>> thanks,
>>>> jirka
>>>>
>>>>
>>>>>
>>>>> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>>>> Cc: Jiri Olsa <jolsa@redhat.com>
>>>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>>>> ---
>>>>>
>>>>> I'm currently preparing packages for d3-flame-graph. For Fedora, 
>>>>> the copr
>>>>> at
>>>>> https://copr.fedorainfracloud.org/coprs/agerstmayr/reviews/package/js-d3-flame-graph/ 
>>>>>
>>>>> can be installed, or alternatively the prebuilt standalone 
>>>>> d3-flame-graph
>>>>> template can be downloaded from
>>>>> https://raw.githubusercontent.com/andreasgerstmayr/specs/master/reviews/js-d3-flame-graph/template.html 
>>>>>
>>>>> and moved into /usr/share/d3-flame-graph/template.html
>>>>>
>>>>>    .../perf/scripts/python/bin/flamegraph-record |   2 +
>>>>>    .../perf/scripts/python/bin/flamegraph-report |   3 +
>>>>>    tools/perf/scripts/python/flamegraph.py       | 117 
>>>>> ++++++++++++++++++
>>>>>    3 files changed, 122 insertions(+)
>>>>>    create mode 100755 tools/perf/scripts/python/bin/flamegraph-record
>>>>>    create mode 100755 tools/perf/scripts/python/bin/flamegraph-report
>>>>>    create mode 100755 tools/perf/scripts/python/flamegraph.py
>>>>>
>>>>> diff --git a/tools/perf/scripts/python/bin/flamegraph-record 
>>>>> b/tools/perf/scripts/python/bin/flamegraph-record
>>>>> new file mode 100755
>>>>> index 000000000000..725d66e71570
>>>>> --- /dev/null
>>>>> +++ b/tools/perf/scripts/python/bin/flamegraph-record
>>>>> @@ -0,0 +1,2 @@
>>>>> +#!/usr/bin/sh
>>>>> +perf record -g "$@"
>>>>> diff --git a/tools/perf/scripts/python/bin/flamegraph-report 
>>>>> b/tools/perf/scripts/python/bin/flamegraph-report
>>>>> new file mode 100755
>>>>> index 000000000000..b1a79afd903b
>>>>> --- /dev/null
>>>>> +++ b/tools/perf/scripts/python/bin/flamegraph-report
>>>>> @@ -0,0 +1,3 @@
>>>>> +#!/usr/bin/sh
>>>>> +# description: create flame graphs
>>>>> +perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
>>>>> diff --git a/tools/perf/scripts/python/flamegraph.py 
>>>>> b/tools/perf/scripts/python/flamegraph.py
>>>>> new file mode 100755
>>>>> index 000000000000..2e9139ef2c4a
>>>>> --- /dev/null
>>>>> +++ b/tools/perf/scripts/python/flamegraph.py
>>>>> @@ -0,0 +1,117 @@
>>>>> +# flamegraph.py - create flame graphs from perf samples
>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>> +#
>>>>> +# Usage:
>>>>> +#
>>>>> +#  perf record -a -g -F 99 sleep 60
>>>>> +#  perf script report flamegraph
>>>>> +#
>>>>> +# Combined data collection and flamegraph generation:
>>>>> +#
>>>>> +#  perf script flamegraph -a -F 99 sleep 60
>>>>> +#
>>>>> +# Written by Andreas Gerstmayr <agerstmayr@redhat.com>
>>>>> +# Flame Graphs invented by Brendan Gregg <bgregg@netflix.com>
>>>>> +# Works in tandem with d3-flame-graph by Martin Spier 
>>>>> <mspier@netflix.com>
>>>>> +
>>>>> +import sys
>>>>> +import os
>>>>> +import argparse
>>>>> +import json
>>>>> +
>>>>> +
>>>>> +class Node:
>>>>> +    def __init__(self, name, libtype=""):
>>>>> +        self.name = name
>>>>> +        self.libtype = libtype
>>>>> +        self.value = 0
>>>>> +        self.children = []
>>>>> +
>>>>> +
>>>>> +class FlameGraphCLI:
>>>>> +    def __init__(self, args):
>>>>> +        self.args = args
>>>>> +        self.stack = Node("root")
>>>>> +
>>>>> +        if self.args.format == "html" and \
>>>>> +                not os.path.isfile(self.args.template):
>>>>> +            print(f"Flame Graph template '{self.args.template}' 
>>>>> does not " +
>>>>> +                  f"exist. Please install the d3-flame-graph 
>>>>> package, " +
>>>>> +                  f"specify an existing flame graph template " +
>>>>> +                  f"(--template PATH) or another output format " +
>>>>> +                  f"(--format FORMAT).", file=sys.stderr)
>>>>> +            sys.exit(1)
>>>>> +
>>>>> +    def find_or_create_node(self, node, name, dso):
>>>>> +        libtype = "kernel" if dso == "[kernel.kallsyms]" else ""
>>>>> +        if name is None:
>>>>> +            name = "[unknown]"
>>>>> +
>>>>> +        for child in node.children:
>>>>> +            if child.name == name and child.libtype == libtype:
>>>>> +                return child
>>>>> +
>>>>> +        child = Node(name, libtype)
>>>>> +        node.children.append(child)
>>>>> +        return child
>>>>> +
>>>>> +    def process_event(self, event):
>>>>> +        node = self.find_or_create_node(self.stack, event["comm"], 
>>>>> None)
>>>>> +        if "callchain" in event:
>>>>> +            for entry in reversed(event['callchain']):
>>>>> +                node = self.find_or_create_node(
>>>>> +                    node, entry.get("sym", {}).get("name"), 
>>>>> event.get("dso"))
>>>>> +        else:
>>>>> +            node = self.find_or_create_node(
>>>>> +                node, entry.get("symbol"), event.get("dso"))
>>>>> +        node.value += 1
>>>>> +
>>>>> +    def trace_end(self):
>>>>> +        def encoder(x): return x.__dict__
>>>>> +        json_str = json.dumps(self.stack, default=encoder,
>>>>> +                              indent=self.args.indent)
>>>>> +
>>>>> +        if self.args.format == "html":
>>>>> +            try:
>>>>> +                with open(self.args.template) as f:
>>>>> +                    output_str = f.read().replace("/** 
>>>>> @flamegraph_params **/",
>>>>> +                                                  json_str)
>>>>> +            except IOError as e:
>>>>> +                print(f"Error reading template file: {e}", 
>>>>> file=sys.stderr)
>>>>> +                sys.exit(1)
>>>>> +            output_fn = self.args.output or "flamegraph.html"
>>>>> +        else:
>>>>> +            output_str = json_str
>>>>> +            output_fn = self.args.output or "stacks.json"
>>>>> +
>>>>> +        if output_fn == "-":
>>>>> +            sys.stdout.write(output_str)
>>>>> +        else:
>>>>> +            try:
>>>>> +                with open(output_fn, "w") as out:
>>>>> +                    out.write(output_str)
>>>>> +            except IOError as e:
>>>>> +                print(f"Error writing output file: {e}", 
>>>>> file=sys.stderr)
>>>>> +                sys.exit(1)
>>>>> +
>>>>> +
>>>>> +if __name__ == "__main__":
>>>>> +    parser = argparse.ArgumentParser(description="Create flame 
>>>>> graphs.")
>>>>> +    parser.add_argument("-F", "--format",
>>>>> +                        default="html", choices=["json", "html"],
>>>>> +                        help="output file format")
>>>>> +    parser.add_argument("-o", "--output",
>>>>> +                        help="output file name")
>>>>> +    parser.add_argument("--indent",
>>>>> +                        type=int, help="JSON indentation")
>>>>> +    parser.add_argument("--template",
>>>>> +                        
>>>>> default="/usr/share/d3-flame-graph/template.html",
>>>>> +                        help="path to flamegraph HTML template")
>>>>> +    parser.add_argument("-i", "--input",
>>>>> +                        help=argparse.SUPPRESS)
>>>>> +
>>>>> +    args = parser.parse_args()
>>>>> +    cli = FlameGraphCLI(args)
>>>>> +
>>>>> +    process_event = cli.process_event
>>>>> +    trace_end = cli.trace_end
>>>>> -- 
>>>>> 2.24.1
>>>>>
>>>>
>>>
>>

