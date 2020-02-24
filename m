Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A00AC16A338
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 10:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBXJz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 04:55:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49257 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgBXJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:55:27 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j6AST-0007Qj-D2; Mon, 24 Feb 2020 10:55:25 +0100
Date:   Mon, 24 Feb 2020 10:55:25 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     zanussi@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT 22/25] mm/memcontrol: Move misplaced
 local_unlock_irqrestore()
Message-ID: <20200224095525.coyyazg5hee4o6uy@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
 <960a2d2ccb60853d52f0dab91e391473dfa6035e.1582320278.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <960a2d2ccb60853d52f0dab91e391473dfa6035e.1582320278.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-21 15:24:50 [-0600], zanussi@kernel.org wrote:
> From: Matt Fleming <matt@codeblueprint.co.uk>
> 
> v4.14.170-rt75-rc1 stable review patch.
> If anyone has any objections, please let me know.

For this and the three following: Please skip it if it is not (yet) part
of v4.19-RT.

Sebastian
