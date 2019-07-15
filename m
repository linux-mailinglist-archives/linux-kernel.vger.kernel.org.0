Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0753168A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 15:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbfGONIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 09:08:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47654 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730019AbfGONIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:08:52 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hn0ih-0006Ku-9b; Mon, 15 Jul 2019 15:08:43 +0200
Date:   Mon, 15 Jul 2019 15:08:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joerg Roedel <joro@8bytes.org>
cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/3] x86/mm: Check for pfn instead of page in
 vmalloc_sync_one()
In-Reply-To: <20190715110212.18617-2-joro@8bytes.org>
Message-ID: <alpine.DEB.2.21.1907151508210.1722@nanos.tec.linutronix.de>
References: <20190715110212.18617-1-joro@8bytes.org> <20190715110212.18617-2-joro@8bytes.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019, Joerg Roedel wrote:

> From: Joerg Roedel <jroedel@suse.de>
> 
> Do not require a struct page for the mapped memory location
> because it might not exist. This can happen when an
> ioremapped region is mapped with 2MB pages.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Lacks a Fixes tag, hmm?

