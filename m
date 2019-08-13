Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28EFD8BD0D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfHMP2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 11:28:02 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:44932 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfHMP2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:28:02 -0400
Received: from [167.98.27.226] (helo=[10.35.5.101])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hxYiN-0006Cf-ER; Tue, 13 Aug 2019 16:27:59 +0100
Subject: Re: [PATCH 01/16] ARM: remove ks8695 platform
To:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org
Cc:     Greg Ungerer <gerg@kernel.org>, Andrew Victor <linux@maxim.org.za>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190809202749.742267-1-arnd@arndb.de>
 <20190809202749.742267-2-arnd@arndb.de>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <3d6c7162-f802-6869-77cb-27aa456b237d@codethink.co.uk>
Date:   Tue, 13 Aug 2019 16:27:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190809202749.742267-2-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2019 21:27, Arnd Bergmann wrote:
> ks8695 is an older SoC originally made by Kendin, which was later acquired
> by Micrel, and subsequently by Microchip.
> 
> The platform port was originally contributed by Andrew Victor and Ben
> Dooks, and later maintained by Greg Ungerer.
> 
> When I recently submitted cleanups, but Greg noted that the platform no
> longer boots and nobody is using it any more, we decided to remove it.
> 
> Cc: Greg Ungerer <gerg@kernel.org>
> Cc: Andrew Victor <linux@maxim.org.za>
> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
> Link: https://wikidevi.com/wiki/Micrel
> Link: https://lore.kernel.org/linux-arm-kernel/2bc41895-d4f9-896c-0726-0b2862fcbf25@kernel.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ben Dooks <ben-linux@fluff.org>
