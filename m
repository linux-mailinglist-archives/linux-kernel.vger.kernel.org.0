Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCC1107180
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 12:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfKVLgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 06:36:02 -0500
Received: from foss.arm.com ([217.140.110.172]:46170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfKVLgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:36:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82058328;
        Fri, 22 Nov 2019 03:36:01 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B71083F703;
        Fri, 22 Nov 2019 03:36:00 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:35:53 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Torsten Duwe <duwe@suse.de>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: KASAN_INLINE && patchable-function-entry
Message-ID: <20191122113553.GA16287@lakrids.cambridge.arm.com>
References: <20191121183630.GA3668@lakrids.cambridge.arm.com>
 <20191121142737.69978ef9@oasis.local.home>
 <20191122113257.GB15749@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122113257.GB15749@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 11:32:57AM +0000, Mark Rutland wrote:
 
> Another option would be to have arm64's ftrace_adjust_addr() detect this
> case and return NULL, given we don't need to perform any call site
> initialization for the redundant NOPs. I'm just not sure if we have all
> the necessary information at that point, though.

Whoops; I meant ftrace_call_adjust() above.

Mark.
