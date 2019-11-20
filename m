Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BDE103CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 15:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfKTOIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 09:08:30 -0500
Received: from nautica.notk.org ([91.121.71.147]:41336 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbfKTOI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:08:29 -0500
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Nov 2019 09:08:29 EST
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 4ED5BC009; Wed, 20 Nov 2019 15:02:01 +0100 (CET)
Date:   Wed, 20 Nov 2019 15:01:46 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH] 9p: Fix Kconfig indentation
Message-ID: <20191120140146.GA21065@nautica>
References: <20191120134340.16770-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191120134340.16770-1-krzk@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski wrote on Wed, Nov 20, 2019:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig

I take it janitors weren't interested in these?

Since it's just 9p I can take it, but if this is the only patch I get it
might take a couple of months to get in.
Will do depending on your answer.

-- 
Dominique
