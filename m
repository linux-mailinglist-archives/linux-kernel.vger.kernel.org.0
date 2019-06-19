Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C114C4BE61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfFSQhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 12:37:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSQho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jhhYcGCAiJkqdIpiThp2i57JDwcfO4J0ArQ48m/bbuk=; b=GQwj/pDLDH/eyuOIVaOTZxLHX
        +5Ca5ERpr7E3VL4I2tt1+G+omsxnJC8ddi46Rtbx1XK5AcETrImA2BLWvJ6tOMlRewYMmtL36w/1W
        MD7RSWgCypMZUQv1LGFlGg1lXJrdXerKiEx1UlWXaq5c/snsVYNU0i9lUhK0tnZ7JUEW0Mkb9K4rv
        CI5dduxBfUfiQ14hNcNVqrPGppE+phayF0jL9lm8g6NuA0nN9Jhg5luJqLb2ad09fm7u1xw2PUs/W
        ZNhhzMJgqE0iOr/THT54MJqd5zAGFXAjE17GgU0qrpHKTEKw9buhoZn/GGNO91kviLkOi/5ulaC1O
        RyCiTw4Mg==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hddah-0002Ki-0U; Wed, 19 Jun 2019 16:37:43 +0000
Date:   Wed, 19 Jun 2019 13:37:39 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 12/14] doc-rst: add ABI documentation to the admin-guide
 book
Message-ID: <20190619133739.44f92409@coco.lan>
In-Reply-To: <87h88nth3v.fsf@intel.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
        <9da2a7f6ff57d9d53dcbb964eb310f7956522870.1560477540.git.mchehab+samsung@kernel.org>
        <87o930uvur.fsf@intel.com>
        <20190614140603.GB7234@kroah.com>
        <20190614122755.1c7b4898@coco.lan>
        <874l4ov16m.fsf@intel.com>
        <20190617105154.3874fd89@coco.lan>
        <87h88nth3v.fsf@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 18 Jun 2019 11:47:32 +0300
Jani Nikula <jani.nikula@linux.intel.com> escreveu:

> On Mon, 17 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> > Yeah, I guess it should be possible to do that. How a python script
> > can identify if it was called by Sphinx, or if it was called directly?  
> 
> if __name__ == '__main__':
> 	# run on the command-line, not imported

Ok, when I have some spare time, I may try to convert one script
to python and see how it behaves. 

Thanks,
Mauro
