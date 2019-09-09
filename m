Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F18DAD301
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 08:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfIIGOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 02:14:06 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:53255 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfIIGOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 02:14:06 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id ABC2F21B; Mon,  9 Sep 2019 06:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=valentin-vidic.from.hr; s=2017; t=1568009640;
        bh=019Xp0m77GdgTGWg3mqqaF5ta6E621OA5OPgyj1seJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NdYxgthLIh2SuB2tEdFH83Lt0Cz9phFTn5DFigIcBCG5e+rfjcfK4MFNKJeTVUDKK
         tgsDWMsysBxqhBfqlIZ35lkWrAl4cWaNHMZj5DD0GYpJQhRXJQKL21a7hWCuP0Ve3m
         10lmKuChJsHOakHRsIBHgVKyWfSL9ezLVsU/pXFdJYZROMeSGYNzvnmtprJXoNO6yN
         UxsalzndIYxY7a8caAQY7b/Hl5hUjgT7sBQCZ+faAl5TAs7In0hyLuzx5y00yqBOzm
         KE7Ie5TSkTO7JPwtUk9SWjRNcqUMYrrP+zsHZ589MV4ooL9PxiquFu32+wt4VV3VvI
         r+omQcz6d8SNg==
Date:   Mon, 9 Sep 2019 06:14:00 +0000
From:   Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] staging: exfat: drop unused field access_time_ms
Message-ID: <20190909061400.GI7664@valentin-vidic.from.hr>
References: <20190908161015.26000-1-vvidic@valentin-vidic.from.hr>
 <20190908161015.26000-2-vvidic@valentin-vidic.from.hr>
 <1049678.1567988361@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1049678.1567988361@turing-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 08:19:21PM -0400, Valdis Klētnieks wrote:
> In that case, rather than removing it, shouldn't we be *adding*
> code to properly set it instead?

Right, setting the UtcOffset fields to 0 is the first step marking
them as invalid for now. This is also why access_time_ms did not do
any harm here - it was always set to 0 too.

7.4.10.2 OffsetValid Field

The OffsetValid field shall describe whether the contents of the OffsetFromUtc
field are valid or not, as follows:

    0, which means the contents of the OffsetFromUtc field are invalid
       and shall be 00h

    1, which means the contents of the OffsetFromUtc field are valid

-- 
Valentin
