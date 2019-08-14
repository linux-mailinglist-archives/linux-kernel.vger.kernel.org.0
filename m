Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 123978DE78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 22:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfHNULK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 16:11:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:39568 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbfHNULJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:11:09 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7EKAi95012038;
        Wed, 14 Aug 2019 15:10:44 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x7EKAh6H012037;
        Wed, 14 Aug 2019 15:10:43 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 14 Aug 2019 15:10:42 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: rewrite LOAD_REG_IMMEDIATE() as an intelligent macro
Message-ID: <20190814201042.GH31406@gate.crashing.org>
References: <61d2a0b6f0c89b1ee546851ce9b6bd345e5ec968.1565690241.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61d2a0b6f0c89b1ee546851ce9b6bd345e5ec968.1565690241.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Tue, Aug 13, 2019 at 09:59:35AM +0000, Christophe Leroy wrote:
> +		rldicr	\r, \r, 32, 31

Could you please write this as
		sldi	\r, \r, 32
?  It's much easier to read, imo (it's the exact same instruction).

You can do a lot cheaper sequences if you have a temporary reg, as well
(longest path of 3 insns instead of 5):
	lis rt,A
	ori rt,B
	lis rd,C
	ori rd,D
	rldimi rd,rt,32,0
to load ABCD.


Segher
