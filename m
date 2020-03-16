Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC421872A1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 19:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbgCPSo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 14:44:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:43116 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732266AbgCPSo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:44:28 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 02GIhfj4002112;
        Mon, 16 Mar 2020 13:43:41 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 02GIhe5d002111;
        Mon, 16 Mar 2020 13:43:40 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 16 Mar 2020 13:43:39 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org, apopple@linux.ibm.com, peterz@infradead.org,
        fweisbec@gmail.com, oleg@redhat.com, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, paulus@samba.org, jolsa@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        mingo@kernel.org
Subject: Re: [PATCH 00/15] powerpc/watchpoint: Preparation for more than one watchpoint
Message-ID: <20200316184339.GB22482@gate.crashing.org>
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com> <b7148b91-e3db-d48a-7294-5c18fc801933@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7148b91-e3db-d48a-7294-5c18fc801933@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 04:05:01PM +0100, Christophe Leroy wrote:
> Some book3s (e300 family for instance, I think G2 as well) already have 
> a DABR2 in addition to DABR.

The original "G2" (meaning 603 and 604) do not have DABR2.  The newer
"G2" (meaning e300) does have it.  e500 and e600 do not have it either.

Hope I got that right ;-)


Segher
