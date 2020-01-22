Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEC1144DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 09:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgAVIog convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Jan 2020 03:44:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37068 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgAVIog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:44:36 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iuBc8-0004VU-H6; Wed, 22 Jan 2020 09:43:52 +0100
Date:   Wed, 22 Jan 2020 09:43:52 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>, Borislav Petkov <bp@suse.de>,
        Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Austin Clements <austin@google.com>,
        Barret Rhoden <brho@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Chase <drchase@golang.org>,
        "H. Peter Anvin" <hpa@zytor.com>, ian@airs.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Bleecher Snyder <josharian@gmail.com>,
        x86-ml <x86@kernel.org>, stable-rt@vger.kernel.org
Subject: Re: [PATCH RT 27/32] x86/fpu: Dont cache access to
 fpu_fpregs_owner_ctx
Message-ID: <20200122084352.nyqnlfaumjgnvgih@linutronix.de>
References: <20200117174111.282847363@goodmis.org>
 <20200117174131.455165326@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200117174131.455165326@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-17 12:41:38 [-0500], Steven Rostedt wrote:
> 4.19.94-rt39-rc1 stable review patch.
> If anyone has any objections, please let me know.
> 
…
> Fixes: 5f409e20b7945 ("x86/fpu: Defer FPU state load until return to userspace")

This isn't needed for the v4.19 tree. As far as I can tell, there is no
"Defer FPU state load until return to userspace" in it.

Sebastian
