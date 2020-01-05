Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 647DA1305A9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jan 2020 05:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgAEEJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 23:09:54 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53718 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgAEEJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 23:09:53 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1inxEH-0027yC-TE; Sun, 05 Jan 2020 04:09:37 +0000
Date:   Sun, 5 Jan 2020 04:09:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Evan Rudford <zocker76@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Is the Linux kernel underfunded? Lack of quality and security?
Message-ID: <20200105040929.GD8904@ZenIV.linux.org.uk>
References: <CAE90CG6SGWKXToVhY5VH-AzUjC6UEwRzoisUXM0OQe9XgcCHRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE90CG6SGWKXToVhY5VH-AzUjC6UEwRzoisUXM0OQe9XgcCHRA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2020 at 04:47:33AM +0100, Evan Rudford wrote:

> - Although the kernel will always remain in C, make serious efforts to
> introduce a safe language for kernel modules and perhaps for some
> subsystems.

Let me see if I've got it right - you suggest introducing an infrastructure
that would provide the bindings between the core kernel and those "safe
language modules" and maintaining its safety (from those languages' point
of view) through the changes of said core kernel *and* through the changes
of ABI of the languages in question?  That takes an impressive skillset
from the poor sods in question - on the level of people actively working
on the language implementation, _in_ _addition_ _to_ what's normally
required for the kernel work.  And that happy group would have to keep
track of the kernel changes.  That will certainly make everything more
secure; I just wonder where have you found the funding to cover the costs
of psychiatric care for the victims^Wproud members of that august group.
You do have that funding lined up, right?
