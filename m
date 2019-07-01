Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7322048310
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 14:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfFQMv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 08:51:28 -0400
Received: from foss.arm.com ([217.140.110.172]:48786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfFQMv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:51:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B29512B;
        Mon, 17 Jun 2019 05:51:26 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 781E93F246;
        Mon, 17 Jun 2019 05:51:25 -0700 (PDT)
Date:   Mon, 17 Jun 2019 13:51:23 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v3 0/6] sched: Add new tracepoints required for EAS
 testing
Message-ID: <20190617125122.ph4wb7mcvfjwpdce@e107158-lin.cambridge.arm.com>
References: <20190604111459.2862-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190604111459.2862-1-qais.yousef@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter

On 06/04/19 12:14, Qais Yousef wrote:
> Changes in v3:
> 	- Split pelt_rq TP into pelt_cfs, pelt_rq, pelt_dl and pelt_irq
> 	- Replace the fatty preprocessing wrappers with exported helper
> 	  functions to access data in unexported structures.
> 	- Remove the now unnecessary headers that were introduced in the
> 	  previous versions.
> 	- Postfix the tracepoints with '_tp' to make them standout more in the
> 	  code as bare tracepoints with no events associated.
> 	- Updated the example module in [2]
> 		- It demonstrates now how to convert the tracepoints into trace
> 		  events that extend the sched events subsystem in tracefs.

Does this look okay now? If you have further comments please let me know so
I can address them in time in hope it'd make it to the next merge window.

Thanks

--
Qais Yousef
