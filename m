Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7543D9A0AF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 22:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392481AbfHVUEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 16:04:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbfHVUEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:04:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 747B63082E25;
        Thu, 22 Aug 2019 20:04:09 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D3796012A;
        Thu, 22 Aug 2019 20:04:08 +0000 (UTC)
Date:   Thu, 22 Aug 2019 15:04:06 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com
Subject: Re: [RFC v4 07/18] objtool: Introduce INSN_UNKNOWN type
Message-ID: <20190822200406.jc3yf77pomxxwep6@treble>
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190816122403.14994-8-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816122403.14994-8-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 22 Aug 2019 20:04:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:23:52PM +0100, Raphael Gault wrote:
> On arm64 some object files contain data stored in the .text section.
> This data is interpreted by objtool as instruction but can't be
> identified as a valid one. In order to keep analysing those files we
> introduce INSN_UNKNOWN type. The "unknown instruction" warning will thus
> only be raised if such instructions are uncountered while validating an
> execution branch.
> 
> This change doesn't impact the x86 decoding logic since 0 is still used
> as a way to specify an unknown type, raising the "unknown instruction"
> warning during the decoding phase still.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>

Is there a reason such data can't be moved to .rodata?  That would seem
like the proper fix.

-- 
Josh
