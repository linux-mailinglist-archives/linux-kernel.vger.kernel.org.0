Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC5C08A93A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 23:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfHLVWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 17:22:36 -0400
Received: from ms.lwn.net ([45.79.88.28]:37172 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbfHLVWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:22:35 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 47AE8737;
        Mon, 12 Aug 2019 21:22:35 +0000 (UTC)
Date:   Mon, 12 Aug 2019 15:22:34 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation/arm/sa1100: Remove some obsolete
 documentation
Message-ID: <20190812152234.267a609d@lwn.net>
In-Reply-To: <20190808165929.16946-1-j.neuschaefer@gmx.net>
References: <20190808165929.16946-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Aug 2019 18:58:55 +0200
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> The support for the following boards, among others, was removed in 2004
> with commit "[ARM] Remove broken SA1100 machine support.":
> 
> - ADS Bitsy
> - Brutus
> - Freebird
> - ADS GraphicsClient Plus
> - ADS GraphicsMaster
> - Höft & Wessel Webpanel
> - Compaq Itsy
> - nanoEngine
> - Pangolin
> - PLEB
> - Yopy
> 
> Tifon support has been removed in 2.4.3.3.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Well, you know, we don't like to be too hasty about such things...:)

Applied, thanks for helping to clean out some of the cobwebs!

jon
