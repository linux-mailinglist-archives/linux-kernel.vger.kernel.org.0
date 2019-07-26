Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD57676F93
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 19:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfGZRMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 13:12:47 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:36789 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727328AbfGZRMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:12:46 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud8.xs4all.net with ESMTPSA
        id r3lphnQp1qTdhr3lshaZGG; Fri, 26 Jul 2019 19:12:45 +0200
Message-ID: <349f9bb3f0c56be1ea43789eab10046d044ce960.camel@tiscali.nl>
Subject: Re: [VDSO] [x86_32] v5-3-rc1 needs vdso32=0 to get systemd-journald
 running
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 26 Jul 2019 19:12:41 +0200
In-Reply-To: <20190726162044.GA5978@linux.intel.com>
References: <618de21a4510f20f1b38a894517b5e9011f0da69.camel@tiscali.nl>
         <20190726162044.GA5978@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLBamVbp4yE2sdvo9AQ5YjWwsrDuZTEGbXsDziFtqfyDK3bUaiCwhnd4tEbM9zkag77/vssHqoCxXDGoxEEtzqkRotDtqx/80Y1h9FWI3Y3GMU0luAqu
 93s0WN/vbXqq7++95VQi7WIwFzrfPGAPk+WsEzkskeS2nqIjB7nsrLLS+wGHobQRZlZCYBu0TbFUCYVi7dbufTJeWi+btjjFrYWc82iBDOVzSUIHv4MtqSPu
 65hOTspazmWFjE9H53aPyz53rEfPL3niii6TWr50jf8wSjZ5FPR1SaoAUgU6LVNv8a9m5Mjgfq8x6loZ5ZSxKoSzXrdJTmydOfM3b3PWP4ONbyT7m0hwTdsI
 TItfwHTRuZ+sjo5mU8+7FAylwT4nAC4vPNJHF1CwLcygmeRc1Dg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson schreef op vr 26-07-2019 om 09:20 [-0700]:
> More than likely it's this:
> 
> https://lkml.kernel.org/r/20190719170343.GA13680@linux.intel.com

Yes.

systemctl --version prints +SECCOMP so I guess systemd-journald has it enabled
too. So I now know which thread I should check. (The subject of that thread
contains "[5.2 REGRESSION]", but I'd say "[5.3-rc1 REGRESSION]" would more
accurate, but whatever.)

Thanks,


Paul Bolle

