Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB7A194EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 03:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgC0CaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 22:30:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47856 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgC0CaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:30:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHel5-003hKA-Mt; Fri, 27 Mar 2020 02:30:08 +0000
Date:   Fri, 27 Mar 2020 02:30:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCHSET v2] x86 uaccess cleanups
Message-ID: <20200327023007.GS23230@ZenIV.linux.org.uk>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
 <20200327022430.GQ23230@ZenIV.linux.org.uk>
 <20200327022633.GR23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327022633.GR23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 02:26:33AM +0000, Al Viro wrote:
> On Fri, Mar 27, 2020 at 02:24:30AM +0000, Al Viro wrote:
> 
> > 21/22	x86: unsafe_put_... macros for sigcontext and sigmask
> 
> Sorry, that would be "x86: unsafe_put-style macro for sigmask";
> sigcontext wrapper migrated into 17/21.

... and the wrong set of patches got sent (futex ones).  I really
need to get some sleep...
