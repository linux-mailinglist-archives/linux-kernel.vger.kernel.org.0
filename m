Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C96556D8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 20:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbfFYSQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 14:16:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:45226 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729748AbfFYSQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:16:02 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5PIFp1g019975;
        Tue, 25 Jun 2019 13:15:51 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x5PIFnSa019974;
        Tue, 25 Jun 2019 13:15:49 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 25 Jun 2019 13:15:49 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib/mpi: fix build with clang
Message-ID: <20190625181549.GK7313@gate.crashing.org>
References: <20190621071342.17897-1-malat@debian.org> <20190621195555.20615-1-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621195555.20615-1-malat@debian.org>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Fri, Jun 21, 2019 at 09:55:54PM +0200, Mathieu Malaterre wrote:
> Remove superfluous casts on output operands to avoid warnings on the
> following macros:
> 
> * add_ssaaaa(sh, sl, ah, al, bh, bl)
> * sub_ddmmss(sh, sl, ah, al, bh, bl)
> * umul_ppmm(ph, pl, m0, m1)

The patch is fine of course, but you might want to look at not using
these asm macros at all: GCC can handle multi-word arithmetic just fine
by itself, probably better than these macros do even.


Segher
