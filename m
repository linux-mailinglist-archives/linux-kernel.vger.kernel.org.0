Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02276F267
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 11:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfD3JCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 05:02:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45897 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfD3JCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:02:02 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hLOeG-0008GS-4S; Tue, 30 Apr 2019 11:02:00 +0200
Date:   Tue, 30 Apr 2019 11:02:00 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH REPOST] random: Add a spinlock_t to struct batched_entropy
Message-ID: <20190430090159.oqyahpmjgu2kta2j@linutronix.de>
References: <20190426103438.g5i5cexlatlgpije@linutronix.de>
 <20190428182928.GD24089@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190428182928.GD24089@mit.edu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-28 14:29:28 [-0400], Theodore Ts'o wrote:
> This patch is already on the random.git tree.  (It wasn't in
> linux-next because I had forgotten that linux-next pulls from the dev
> branch, as opposed to the master branch.)

Oh, Thank you!

> Cheers,
> 
> 					- Ted

Sebastian
