Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6671F17409A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 20:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgB1T4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 14:56:45 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36826 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1T4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:56:44 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7lkV-002ZFK-P1; Fri, 28 Feb 2020 19:56:39 +0000
Date:   Fri, 28 Feb 2020 19:56:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: Minimize uaccess exposure in
 i915_gem_execbuffer2_ioctl()
Message-ID: <20200228195639.GL23230@ZenIV.linux.org.uk>
References: <ed52cfb852d2772bf20f48614d75f1d1b1451995.1582841072.git.jpoimboe@redhat.com>
 <20200227223542.GE23230@ZenIV.linux.org.uk>
 <20200228010342.3j3awgvvgvitif7z@treble>
 <20200228180441.GL18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228180441.GL18400@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 07:04:41PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 27, 2020 at 07:03:42PM -0600, Josh Poimboeuf wrote:
> > > And why not mark gen8_canonical_addr() __always_inline?
> > 
> > Right, marking those two functions as __always_inline is the other
> > option.  The problem is, if you keep doing it, eventually you end up
> > with __always_inline-itis spreading all over the place.  And it affects
> > all the other callers, at least in the CONFIG_CC_OPTIMIZE_FOR_SIZE case.
> > At least this fix is localized.
> 
> I'm all for __always_inline in this case, the compiler not inlining sign
> extention is just retarded,

FWIW, in this case it's
        salq    $8, %rax
        sarq    $8, %rax
i.e. 8 bytes.  Sure, that's 3 bytes longer than call, but really, WTF?
