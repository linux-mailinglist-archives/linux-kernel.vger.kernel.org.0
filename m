Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 180B2148AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 16:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388595AbgAXPHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 10:07:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:55974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387698AbgAXPHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:07:45 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFBEB20709;
        Fri, 24 Jan 2020 15:07:43 +0000 (UTC)
Date:   Fri, 24 Jan 2020 10:07:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, mhiramat@kernel.org, borntraeger@de.ibm.com,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf test: Test case 66 broken on s390 (lib/traceevent
 issue)
Message-ID: <20200124100742.4050c15e@gandalf.local.home>
In-Reply-To: <20200124073941.39119-1-tmricht@linux.ibm.com>
References: <20200124073941.39119-1-tmricht@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020 08:39:41 +0100
Thomas Richter <tmricht@linux.ibm.com> wrote:

> Test case 66 'Use vfs_getname probe to get syscall args filenames'
> is broken on s390, but works on x86. The test case fails with:
> 
>  [root@m35lp76 perf]# perf test -F 66
>  66: Use vfs_getname probe to get syscall args filenames
>            :Recording open file:
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.004 MB /tmp/__perf_test.perf.data.TCdYj\
> 	 (20 samples) ]
>  Looking at perf.data file for vfs_getname records for the file we touched:
>   FAILED!
>   [root@m35lp76 perf]#
> 
> The root cause of this failure has to do with
> commit 88903c464321c ("tracing/probe: Add ustring type for user-space string")
> and these changes:
>    +         if (strcmp(parg->type->name, "string") == 0)
>    +                 fmt = ", __get_str(%s)";
>    +          else
>    +                 fmt = ", REC->%s";
> 

You confused me because those changes are not in commit 88903c464321c.
They are in 40b53b771806b ("tracing: probeevent: Add array type
support").

But reading what you wrote a second time, I'm assuming you mean the
user-space string changes and the above changes together make the
problem.

> On x86 __get_str() function is used to print the file name. This is ok
> for x86 because kernel and user space are in the same adddress space,
> the high bit of the address determines kernel vs user space addresses.
> 
> This approach does not work on s390. On s390 kernel und user space are
> in different address spaces, both start with address 0x0. Which address
> space is currently active is stored in the processor status word (PSW).
> 
> Therefore s390 must use 'ustring' for lookup of filename in the user
> space address space.
> 
> Setting up the kprobe event using perf command:
> 
>  # ./perf probe "vfs_getname=getname_flags:72 pathname=filename:ustring"
> 
> generates this format file:
>   [root@m35lp76 perf]# cat /sys/kernel/debug/tracing/events/probe/\
> 	  vfs_getname/format
>   name: vfs_getname
>   ID: 1172
>   format:
>     field:unsigned short common_type; offset:0; size:2; signed:0;
>     field:unsigned char common_flags; offset:2; size:1; signed:0;
>     field:unsigned char common_preempt_count; offset:3; size:1; signed:0;
>     field:int common_pid; offset:4; size:4; signed:1;
> 
>     field:unsigned long __probe_ip; offset:8; size:8; signed:0;
>     field:__data_loc char[] pathname; offset:16; size:4; signed:1;
> 
>     print fmt: "(%lx) pathname=\"%s\"", REC->__probe_ip, REC->pathname

Hmm, that format looks wrong.

>  [root@m35lp76 perf]#
> 
> The difference between 'ustring' and 'string' is the print fmt statement
> in the last line. Using 'string' generates
> 
>   print fmt: "(%lx) pathname=\"%s\"", REC->__probe_ip, __get_str(pathname)
> 
> This does not work on s390 because __get_str() function does not
> know the address space currently being used.

I don't think this is the issue, as __get_str() is just a way to handle
dynamic sized strings in the ring buffer. It shouldn't care about
kernel vs user space addresses at all.

> 
> This is the command to generate the perf.data file:
> 
>  # ./perf record -e probe:vfs_getname -- touch /tmp/xxx
> 
> This command creates the perf.data file which contains the contents
> for the kprobe event format file. The call chain is:
> 
>   main
>   ....
>   perf_session__open
>   perf_header__process_sections (feature 1 tracing)
>   perf_file_section__process
>   trace_report
>   read_event_files
>   read_event_file
>   parse_event_file
>   tep_parse_event  --> now in lib/traceevent/event-parse.c
>   __parse_event
>   tep_parse_format
>   event_read_format
>   event_read_print
>   event_read_print_args
>   process_args
>   process_arg_token --> processes REC->xxx entry of event format file
>                         'print fmt' line
>   process_entry --> generates argument of type TEP_PRINT_FIELD entry
>                     with TEP_FIELD_IS_STRING set in arg->field.field->flags
> 		    member
> 
> Now the difference in the format file between
>    [x86] print fmt: "(%lx) pathname=\"%s\"", ...,  __get_str(pathname)
> and
>    [s390] print fmt: "(%lx) pathname=\"%s\"", ...,  REC->pathname
> comes into play.
> 
> In the x86 case the function process_arg_token()
> handles in the case TEP_EVENT_ITEM the token "__get_str" and calls
> functions
> 
>   process_function()
>   +--> process_str()
> 
> and creates a print argument structure struct tep_print_arg with
> type TEP_PRINT_STRING.
> This is handled correctly when perf report later prints the argument using
> function print_str_arg() in file lib/traceevent/event-parse.c
> I omit the 35+ plus function call stack of the gdb where command.
> 
> In the s390 case the function process_arg_token()
> handles in the case TEP_EVENT_ITEM the token "REC" and calls
> function
>   process_entry()
> 
> This creates a print argument structure struct tep_print_arg with
> type TEP_PRINT_FIELD and bit TEP_FIELD_IS_STRING set in flags.
> 
> This is handled ***incorrectly** when perf report later prints the
> argument using function print_str_arg() in file
> lib/traceevent/event-parse.c. There is no support to print a string
> when type is TEP_PRINT_FIELD and bit TEP_FIELD_IS_STRING inflags is set.
> Again I omit the 35+ plus function call stack of the gdb where command.
> 
> Output before:
>   [root@m35lp76 perf]# perf report --stdio | egrep '^(# Samp| +[1-9.])+'
>   # Samples: 20  of event 'probe:vfs_getname'
>   100.00%  (4d2c32) pathname=""
> 
> Output after:
>   [root@m35lp76 perf]# ./perf report --stdio | egrep '^(# Samp| +[1-9.])+'
>   # Samples: 20  of event 'probe:vfs_getname'
>   5.00%  (4d2c32) pathname="/etc/ld.so.cache"
>   5.00%  (4d2c32) pathname="/etc/ld.so.preload"
>   5.00%  (4d2c32) pathname="/lib64/libc.so.6"
>   5.00%  (4d2c32) pathname="/tmp/xxx"
>   5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_ADDRESS"
>   5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_COLLATE"
>   5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_CTYPE"
>   5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_IDENTIFICATION"
>   5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_MEASUREMENT"
>   5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_MESSAGES"
>   5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_MESSAGES/SYS_LC_MESSAGES"
>   5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_MONETARY"
>   5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_NAME"
>   5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_NUMERIC"
>   5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_PAPER"
>   5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_TELEPHONE"
>   5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_TIME"
>   5.00%  (4d2c32) pathname="/usr/lib/locale/locale-archive"
>   5.00%  (4d2c32) pathname="/usr/lib64/gconv/gconv-modules.cache"
>   5.00%  (4d2c32) pathname="/usr/share/locale/locale.alias"
>   [root@m35lp76 perf]#
> 
> Fix this by adding print string support for TEP_FIELD_IS_STRING
> bit set in flags and case TEP_PRINT_FIELD.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/lib/traceevent/event-parse.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> index beaa8b8c08ff..68334f860b27 100644
> --- a/tools/lib/traceevent/event-parse.c
> +++ b/tools/lib/traceevent/event-parse.c
> @@ -4003,6 +4003,15 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
>  				trace_seq_printf(s, "%llx", addr);
>  			break;
>  		}
> +		if (field->flags & TEP_FIELD_IS_STRING) {
> +			int str_offset;
> +
> +			str_offset = tep_data2host4(tep, *(unsigned int *)(data + arg->field.field->offset));
> +			str_offset &= 0xffff;
> +			print_str_to_seq(s, format, len_arg,
> +					 ((char *)data) + str_offset);
> +			break;

This will break static strings.

This looks like a kernel bug, not a libtraceevent parsing bug.

> +		}
>  		str = malloc(len + 1);
>  		if (!str) {
>  			do_warning_event(event, "%s: not enough memory!",

Does this patch fix it for you?

-- Steve

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 905b10af5d5c..d3309fceb480 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -876,7 +876,8 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 	for (i = 0; i < tp->nr_args; i++) {
 		parg = tp->args + i;
 		if (parg->count) {
-			if (strcmp(parg->type->name, "string") == 0)
+			if ((strcmp(parg->type->name, "string") == 0) ||
+			    (strcmp(parg->type->name, "ustring") == 0))
 				fmt = ", __get_str(%s[%d])";
 			else
 				fmt = ", REC->%s[%d]";
@@ -884,7 +885,8 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 				pos += snprintf(buf + pos, LEN_OR_ZERO,
 						fmt, parg->name, j);
 		} else {
-			if (strcmp(parg->type->name, "string") == 0)
+			if ((strcmp(parg->type->name, "string") == 0) ||
+			    (strcmp(parg->type->name, "ustring") == 0))
 				fmt = ", __get_str(%s)";
 			else
 				fmt = ", REC->%s";
