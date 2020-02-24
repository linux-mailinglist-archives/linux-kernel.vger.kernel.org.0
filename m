Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D628616A0F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 10:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgBXJDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 04:03:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48794 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXJDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:03:20 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j69e1-0005kF-R7; Mon, 24 Feb 2020 10:03:17 +0100
Date:   Mon, 24 Feb 2020 10:03:17 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     zanussi@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT 19/25] userfaultfd: Use a seqlock instead of seqcount
Message-ID: <20200224090317.shfeuxfukkvxvqaf@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
 <889f5b989b28eb7b29f21092432948cd12d97c48.1582320278.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <889f5b989b28eb7b29f21092432948cd12d97c48.1582320278.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-21 15:24:47 [-0600], zanussi@kernel.org wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> v4.14.170-rt75-rc1 stable review patch.
> If anyone has any objections, please let me know.

This is required but it is not part of the next "higher" tree
(v4.19-RT). Which means if someone moves from v4.14-RT to the next tree
(v4.19-RT in this case) that someone would have the bug again.

Could you please wait with such patches or did the I miss the v4.19-RT
tree with this change?

Sebastian
