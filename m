Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C238D4D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 15:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfHNNfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 09:35:38 -0400
Received: from foss.arm.com ([217.140.110.172]:54740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfHNNfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:35:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DBC028;
        Wed, 14 Aug 2019 06:35:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 771643F706;
        Wed, 14 Aug 2019 06:35:35 -0700 (PDT)
Date:   Wed, 14 Aug 2019 14:35:33 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com,
        akpm@linux-foundation.org, bp@suse.de, catalin.marinas@arm.com,
        davem@davemloft.net, hch@lst.de, kan.liang@intel.com,
        mingo@kernel.org, peterz@infradead.org, riel@surriel.com
Subject: Re: [PATCH 2/9] sched: treewide: use is_kthread()
Message-ID: <20190814133532.GB51963@lakrids.cambridge.arm.com>
References: <20190814104131.20190-1-mark.rutland@arm.com>
 <20190814104131.20190-3-mark.rutland@arm.com>
 <20190814123918.4e4i6vffr4kif6dx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190814123918.4e4i6vffr4kif6dx@linutronix.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 02:39:19PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-08-14 11:41:24 [+0100], Mark Rutland wrote:
> …
> > Instances checking multiple PF_* flags at ocne are left as-is for now.
> 
> s@ocne@once@
> 
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Whoops; I'll fix that typo now...

Thanks,
Mark
