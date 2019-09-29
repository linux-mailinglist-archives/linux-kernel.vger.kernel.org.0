Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E877C1970
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2019 22:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfI2UPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 16:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbfI2UPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 16:15:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5EB020863;
        Sun, 29 Sep 2019 20:15:39 +0000 (UTC)
Date:   Sun, 29 Sep 2019 16:15:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        mingo@redhat.com, linux@rasmusvillemoes.dk
Subject: Re: [PATCH] Make is_signed_type() simpler
Message-ID: <20190929161531.727da348@gandalf.local.home>
In-Reply-To: <20190929200619.GA12851@avx2>
References: <20190929200619.GA12851@avx2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2019 23:06:19 +0300
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> * Simply compare -1 with 0,
> * Drop unnecessary parenthesis sets
> 
> New macro leaves pointer as "unsigned type" but gives a warning,
> which should be fine because asking whether a pointer is signed is
> strange question.
> 
> I'm not sure what's going on in the i915 driver, it is shipping kernel
> pointers to userspace.

This tells us what the patch does, not why.

-- Steve

> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
