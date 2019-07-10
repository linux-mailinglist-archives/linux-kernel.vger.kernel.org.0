Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D00864872
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 16:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfGJOdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 10:33:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfGJOdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:33:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1478351032;
        Wed, 10 Jul 2019 14:33:52 +0000 (UTC)
Received: from treble (ovpn-112-43.rdu2.redhat.com [10.10.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B28355FCC1;
        Wed, 10 Jul 2019 14:33:50 +0000 (UTC)
Date:   Wed, 10 Jul 2019 09:33:47 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry@arm.com
Subject: Re: [RFC V3 00/18] objtool: Add support for arm64
Message-ID: <20190710143347.pviyxuvenz4rqldb@treble>
References: <20190624095548.8578-1-raphael.gault@arm.com>
 <e4ce2867-1d9c-54f4-73a5-668057e423a7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4ce2867-1d9c-54f4-73a5-668057e423a7@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 10 Jul 2019 14:33:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 08:31:28AM +0100, Raphael Gault wrote:
> Hi all,
> 
> Just a gentle ping to see if anyone has comments to make about this version
> :)

Hi Raphael,

Sorry for the delay.  I haven't forgotten about these patches.  I hope
to do a proper review in the next week or so.

-- 
Josh
