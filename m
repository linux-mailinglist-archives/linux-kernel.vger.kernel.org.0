Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F25146E8C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2019 08:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfFOGPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jun 2019 02:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfFOGPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 02:15:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2C9521841;
        Sat, 15 Jun 2019 06:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560579330;
        bh=anNfzxnyz3KJrgUIo6CRSfLQLWu0Ni1tpj7KOO21kig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z4PLJ71BzIMZi+DisIiIdwrjBYk8m9Iud4IX+XHb9Xq5Zi0j2pah558pP9IzNnAHt
         dogGRLVBbu1Y6nHcq3pzxIbWeVS3NjcD/1HQ/WkxkxEbVA/PsBTTG9rPdfYliaBNm9
         cjNkGzO755VvksLAbZAU8j7T+3g7QwowbaoLz3+4=
Date:   Sat, 15 Jun 2019 08:15:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 00/16] Add support to generate ABI documentation at
 admin-guide
Message-ID: <20190615061524.GA30899@kroah.com>
References: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
 <20190614150736.043cb2dd@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614150736.043cb2dd@coco.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 03:07:36PM -0300, Mauro Carvalho Chehab wrote:
> Greg,
> 
> In time: forgot to add a 00/16 patch... someone come to my desk while I was
> sending this... sorry for that.
> 
> That's the second version of the doc ABI updated logic.
> 
> Changes from version 1:
> 
> - I updated my e-mail on older patches;
> 
> - Two new ABI fix patches;

Both abi fix patches now queued up, thanks.

greg k-h
