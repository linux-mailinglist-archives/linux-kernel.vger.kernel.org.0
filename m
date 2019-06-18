Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4994AE9F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 01:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfFRXPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 19:15:02 -0400
Received: from casper.infradead.org ([85.118.1.10]:37184 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFRXPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 19:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YD3CDBnSmeqzGKbOwCAY3CZKaDLh95sd33iLbp3T1uU=; b=tIsxsufTq7E9IsMbw+MWb0tbC5
        tpANoUwiF+PMZC10fp09AV1FLkM2apZ4V7pwSGklRs1GwLJj3O1MwZ8J90LBorH9Dmez8duksbLtm
        cShMcigdOrSA7sCFxyQcWaT7N8axFoBTwkpa8QuBndEVHaZiObfGTwIcuUNgn85DBs2JypNungCXD
        EvOJNPYlhVQqp73SEcvODHxDzpQ7BeYseALL/9SMAgD9R2qcq22I7QFNyYkpzlY/9awUykhfFbAkD
        CSew9zhOgBJyNLcg0y47R8Ak4J+B0pc1ozqDJLk5GzaI4rxOQJajkdOfgziAztoEbkpUhwoPS+/+Q
        tTEAsiBg==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdNJd-0007Mp-B3; Tue, 18 Jun 2019 23:15:01 +0000
Date:   Tue, 18 Jun 2019 20:14:55 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 02/29] docs: lcd-panel-cgram.txt: convert docs to
 ReST and rename to *.rst
Message-ID: <20190618201455.04e8743d@coco.lan>
In-Reply-To: <CANiq72kibf49R+QtUjqcttGiNr4kxBqc0TxSe+HdrQUahTxgng@mail.gmail.com>
References: <cover.1560890800.git.mchehab+samsung@kernel.org>
        <3da3e0379da562d703e6896ded6a7839d1272494.1560890800.git.mchehab+samsung@kernel.org>
        <CANiq72kibf49R+QtUjqcttGiNr4kxBqc0TxSe+HdrQUahTxgng@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 18 Jun 2019 23:14:01 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> escreveu:

> On Tue, Jun 18, 2019 at 10:56 PM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> >
> > This small text file describes the usage of parallel port LCD
> > displays from userspace PoV. So, a good candidate for the
> > admin guide.
> >
> > While this is not part of the admin-guide book, mark it as
> > :orphan:, in order to avoid build warnings.  
> 
> If we are going to move everything else to `.rst` too, even things
> outside the guide, then ack.

Yeah, the plan is to move all text files inside Documentation/ to .rst[1].

[1] There are some exceptions: for ABI and features, the current plan
is to have a script that parses their strict formats and produce
a ReST output.


Btw, Still pending to be sent, I have already a patch removing the
:orphan: from this file and adding it to the admin guide:

	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=convert_rst_renames_v5.1&id=eae5b48cab115c83be8dd59ee99b9e45f8142134

And the corresponding output, after the patches I currently have:

	https://www.infradead.org/~mchehab/rst_conversion/admin-guide/lcd-panel-cgram.html

Thanks,
Mauro
