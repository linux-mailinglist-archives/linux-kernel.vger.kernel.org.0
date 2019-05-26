Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42742AB62
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 19:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfEZRfI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 26 May 2019 13:35:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46285 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfEZRfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 13:35:07 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hUx2z-00027N-Gj; Sun, 26 May 2019 19:35:01 +0200
Date:   Sun, 26 May 2019 19:35:01 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Hugh Dickins <hughd@google.com>, x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/fpu: Use fault_in_pages_writeable() for pre-faulting
Message-ID: <20190526173501.6pdufup45rc2omeo@linutronix.de>
References: <20190526173325.lpt5qtg7c6rnbql5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190526173325.lpt5qtg7c6rnbql5@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-26 19:33:25 [+0200], To Hugh Dickins wrote:
> From: Hugh Dickins <hughd@google.com>
…
> Signed-off-by: Hugh Dickins <hughd@google.com>

Hugh, I took your patch, slapped a signed-off-by line. Please say that
you are fine with it (or object otherwise).

Sebastian
