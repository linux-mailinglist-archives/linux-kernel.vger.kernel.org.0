Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F06718A25C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 19:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgCRSbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 14:31:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:51356 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRSbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:31:08 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 02IIUQYD002064;
        Wed, 18 Mar 2020 13:30:26 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 02IIUOWq002063;
        Wed, 18 Mar 2020 13:30:24 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 18 Mar 2020 13:30:24 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org, apopple@linux.ibm.com, peterz@infradead.org,
        fweisbec@gmail.com, oleg@redhat.com, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, paulus@samba.org, jolsa@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        mingo@kernel.org
Subject: Re: [PATCH 02/15] powerpc/watchpoint: Add SPRN macros for second DAWR
Message-ID: <20200318183024.GJ22482@gate.crashing.org>
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com> <20200309085806.155823-3-ravi.bangoria@linux.ibm.com> <0a45786d-f44b-8717-3aed-dfcfcb1856bb@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a45786d-f44b-8717-3aed-dfcfcb1856bb@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 11:16:34AM +0100, Christophe Leroy wrote:
> 
> 
> Le 09/03/2020 à 09:57, Ravi Bangoria a écrit :
> >Future Power architecture is introducing second DAWR. Add SPRN_ macros
> >for the same.
> 
> I'm not sure this is called 'macros'. For me a macro is something more 
> complex.

It is called "macros" in the C standard, and in common usage as well.
"Object-like macros", as opposed to "function-like macros": there are
no arguments.

> For me those are 'constants'.

That would be more like "static const" in C since 1990 ;-)


Segher
