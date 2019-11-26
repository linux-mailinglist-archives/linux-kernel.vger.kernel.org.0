Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0542810A4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 20:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKZTvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 14:51:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfKZTvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:51:04 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7244A207DD;
        Tue, 26 Nov 2019 19:51:03 +0000 (UTC)
Date:   Tue, 26 Nov 2019 14:51:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        andriy.shevchenko@intel.com, cezary.rojewski@intel.com,
        gustaw.lewandowski@intel.com
Subject: Re: [PATCH v2 2/2] tracing: Use seq_buf_hex_dump() to dump buffers
Message-ID: <20191126145101.1e6c4e43@gandalf.local.home>
In-Reply-To: <61e34d88-bbf7-a2ff-e983-64dc9be1a482@linux.intel.com>
References: <1573130738-29390-1-git-send-email-piotrx.maziarz@linux.intel.com>
        <1573130738-29390-2-git-send-email-piotrx.maziarz@linux.intel.com>
        <20191113160922.1b1f0fc0@gandalf.local.home>
        <61e34d88-bbf7-a2ff-e983-64dc9be1a482@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 15:53:26 +0100
Piotr Maziarz <piotrx.maziarz@linux.intel.com> wrote:
> Hello Steven,
> 
> I'm writing handle in event-parse and I came across some technical 
> problems. I have an event which print function looks like that:
> TP_printk("%s",
> 	  __print_hex_dump("", DUMP_PREFIX_OFFSET, 16, 4,
> 			   __get_dynamic_array(buf),
> 			   __get_dynamic_array_len(buf), false))
> It works properly when printing events to debugfs.
> I'm testing my implementation with trace-cmd and it has problem with 
> parsing DUMP_PREFIX_OFFSET and false (I'm using 
> alloc_and_process_delim()). Instead of having numerical values 
> tep_print_args are of type TEP_PRINT_ATOM and have char array 
> "DUMP_PREFIX_OFFSET" or "true".
> Am I doing something incorrect? Parsing it this way is problematic 
> because instead of false someone may use 0 or logic expression. And 
> writing it to support all possible scenarios may be tedious and prone to 
> errors.

You can force the enum to be a number by including the following in the
trace event header:

TRACE_DEFINE_ENUM(DUMP_PREFIX_OFFSET);
TRACE_DEFINE_ENUM(DUMP_PREFIX_ADDRESS);
TRACE_DEFINE_ENUM(DUMP_PREFIX_NONE);

and the format files will convert these to their actual numbers when
displaying it to user space.

-- Steve

