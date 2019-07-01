Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBE8209A7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 16:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfEPO3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 10:29:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfEPO3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:29:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C85C30C0DCD;
        Thu, 16 May 2019 14:29:22 +0000 (UTC)
Received: from treble (ovpn-120-91.rdu2.redhat.com [10.10.120.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C32860BE0;
        Thu, 16 May 2019 14:29:20 +0000 (UTC)
Date:   Thu, 16 May 2019 09:29:17 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry@arm.com
Subject: Re: [RFC V2 00/16] objtool: Add support for Arm64
Message-ID: <20190516142917.nuhh6dmfiufxqzls@treble>
References: <20190516103655.5509-1-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516103655.5509-1-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 16 May 2019 14:29:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 11:36:39AM +0100, Raphael Gault wrote:
> Noteworthy points:
> * I still haven't figured out how to detect switch-tables on arm64. I
> have a better understanding of them but still haven't implemented checks
> as it doesn't look trivial at all.

Switch tables were tricky to get right on x86.  If you share an example
(or even just a .o file) I can take a look.  Hopefully they're somewhat
similar to x86 switch tables.  Otherwise we may want to consider a
different approach (for example maybe a GCC plugin could help annotate
them).

-- 
Josh
