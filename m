Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 195558D84F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 18:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfHNQos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 12:44:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:49808 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbfHNQos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:44:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8313ABAE;
        Wed, 14 Aug 2019 16:44:46 +0000 (UTC)
Message-ID: <c053e34c9ccbfb663f0918981536c65819b260ad.camel@suse.de>
Subject: Re: [PATCH] regmap: fix writes to non incrementing registers
From:   Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Ben Whitten <ben.whitten@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, nandor.han@vaisala.com
Date:   Wed, 14 Aug 2019 18:44:46 +0200
In-Reply-To: <20190814160543.GH4640@sirena.co.uk>
References: <20190813212251.12316-1-ben.whitten@gmail.com>
         <20190814100115.GF4640@sirena.co.uk>
         <CAF3==iuZvCnmAg9hqs8ivHw0wHaUQEf8k9U8=KTekMMjdyyEKg@mail.gmail.com>
         <4ba5dd72-4a55-c383-0899-62109f10c020@suse.de>
         <20190814160543.GH4640@sirena.co.uk>
Organization: SUSE Linux GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 14.08.2019, 17:05 +0100 schrieb Mark Brown:
> On Wed, Aug 14, 2019 at 03:32:37PM +0200, Andreas Färber wrote:
> 
> > Then please add a Fixes: header to your commit message, so that it
> > gets
> > backported to all affected upstream and downstream trees.
> 
> This still isn't a sensible fix for the reasons I outlined.

No contradiction here.

Cheers,
Andreas

-- 
SUSE Linux GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)

