Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C26875FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 09:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfGZH2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 03:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfGZH2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:28:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68FBC206BF;
        Fri, 26 Jul 2019 07:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564126093;
        bh=i/TsQG/aRjGtN08pB108hr1+zVTBvheG4HDu8u51ElY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QDes1G37ElaM+GFNGJYAcx/3kdsvf2MlcCI1yWqCdqbSirrh3qyuZGyIG/Fho+m8j
         DLZF0x3ivf81FOJcT/bcIf0QcwlPePr2qKa6Va+Ax9PAPPQ3DV8ozicYPZksql3Z7n
         tWVUEyqDXXRVPKk3i/tumBnygJ3Uwbmd035/TmW4=
Date:   Fri, 26 Jul 2019 09:28:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jeyentam <je.yen.tam@ni.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
Message-ID: <20190726072811.GA3073@kroah.com>
References: <20190726072226.6357-1-je.yen.tam@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726072226.6357-1-je.yen.tam@ni.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 03:22:26PM +0800, jeyentam wrote:
> Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> 
> Signed-off-by: Je Yen Tam <je.yen.tam@ni.com>

"From:" name does not match the Signed-off-by: name :(

