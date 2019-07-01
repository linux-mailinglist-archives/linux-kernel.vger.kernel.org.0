Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFEC442231
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 12:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfFLKTW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jun 2019 06:19:22 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:50668 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfFLKTW (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:8:1>);
        Wed, 12 Jun 2019 06:19:22 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Wed, 12 Jun 2019 04:19:21 -0600
Message-Id: <5D00D1A602000078002376A9@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Wed, 12 Jun 2019 04:19:18 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "Borislav Petkov" <bp@alien8.de>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, <tglx@linutronix.de>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <hpa@zytor.com>
Subject: Re: [Xen-devel] [PATCH] x86/xen: disable nosmt in Xen guests
References: <20190612101228.23898-1-jgross@suse.com>
In-Reply-To: <20190612101228.23898-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 12.06.19 at 12:12, <jgross@suse.com> wrote:
> When running as a Xen guest selecting "nosmt" either via command line
> or implicitly via default settings makes no sense, as the guest has no
> clue about the real system topology it is running on. With Xen it is
> the hypervisor's job to ensure the proper bug mitigations are active
> regarding smt settings.

I don't agree with the second sentence: It is in principle fine for the
hypervisor to expose HT (i.e. not disable it as bug mitigation), and
leave it to the guest kernels to protect themselves. We're just not
at the point yet where Xen offers sufficient / reliable data to guest
kernels to do so, so _for the time being_ what you say is correct.

Jan


