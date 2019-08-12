Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A62A8A946
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 23:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfHLV0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 17:26:12 -0400
Received: from ms.lwn.net ([45.79.88.28]:37204 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfHLV0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:26:12 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EEAA6737;
        Mon, 12 Aug 2019 21:26:11 +0000 (UTC)
Date:   Mon, 12 Aug 2019 15:26:11 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/arm/samsung-s3c24xx: Remove stray U+FEFF
 character to fix title
Message-ID: <20190812152611.3e8f5e9d@lwn.net>
In-Reply-To: <20190808164811.15645-1-j.neuschaefer@gmx.net>
References: <20190808164811.15645-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Aug 2019 18:48:09 +0200
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> It seems a UTF-8 byte order mark (the least useful kind of BOM...) snuck
> into the file and broke Sphinx's detection of the title line.
> 
> Besides making arm/samsung-s3c24xx/index.html look a little better, this
> patch also confines the non-index pages in arm/samsung-s3c24xx to their
> own table of contents.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied, thanks.

jon
