Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D093D748
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 21:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406348AbfFKTyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 15:54:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59502 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404282AbfFKTyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:54:43 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hamqg-0004OW-HW; Tue, 11 Jun 2019 21:54:26 +0200
Date:   Tue, 11 Jun 2019 21:54:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH v4 05/21] x86/hpet: Reserve timer for the HPET
 hardlockup detector
In-Reply-To: <1558660583-28561-6-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1906112152430.2214@nanos.tec.linutronix.de>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1558660583-28561-6-git-send-email-ricardo.neri-calderon@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019, Ricardo Neri wrote:

> HPET timer 2 will be used to drive the HPET-based hardlockup detector.
> Reserve such timer to ensure it cannot be used by user space programs or
> for clock events.
> 
> When looking for MSI-capable timers for clock events, skip timer 2 if
> the HPET hardlockup detector is selected.

Why? Both the changelog and the code change lack an explanation why this
timer is actually touched after it got reserved for the platform. The
reservation should make it inaccessible for other things.

Thanks,

	tglx
