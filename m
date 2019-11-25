Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBBDA1085E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 01:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKYAK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Nov 2019 19:10:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55804 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726851AbfKYAK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574640653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UNfSn0Go7nr/5TpyDxXNoKwOWWktGBW2yIqrNptZ/0Q=;
        b=SjvUfzmqMme5/O62rnwg+oIADGzOxHIVr0twYZwWuTSb+yy/wzJlr3BtnkMTXBtGqliTCg
        t+EsjEKwOnqrd6L/gtAOdDwnh6paBJ1n4JVpD1KogpAELSQoSF08wJx39HDLjB1/jU5fiF
        kGESrUVHDe3PnZEAOApX4+3hoKZgTtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-A21YCl6aO_GiDSeGDnec8Q-1; Sun, 24 Nov 2019 19:10:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9DB418B9FC1;
        Mon, 25 Nov 2019 00:10:49 +0000 (UTC)
Received: from suzdal.zaitcev.lan (ovpn-117-3.phx2.redhat.com [10.3.117.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 673D85C1D4;
        Mon, 25 Nov 2019 00:10:48 +0000 (UTC)
Date:   Sun, 24 Nov 2019 18:10:47 -0600
From:   Pete Zaitcev <zaitcev@redhat.com>
Cc:     andreyknvl@google.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        jrdr.linux@gmail.com, keescook@chromium.org,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        zaitcev@redhat.com, tglx@linutronix.de, viro@zeniv.linux.org.uk
Subject: Re: possible deadlock in mon_bin_vma_fault
Message-ID: <20191124181047.7cb9e8fb@suzdal.zaitcev.lan>
In-Reply-To: <000000000000214afd05981ff1a8@google.com>
References: <Pine.LNX.4.44L0.1911241553390.4632-100000@netrider.rowland.org>
        <000000000000214afd05981ff1a8@google.com>
Organization: Red Hat, Inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: A21YCl6aO_GiDSeGDnec8Q-1
X-Mimecast-Spam-Score: 2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2019 15:24:00 -0800
syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com> wrote:

> syzbot has tested the proposed patch and the reproducer did not trigger  
> crash:

Okay. Alan, what is the most appropriate tree for me to submit now?
Does Greg have one?

Do you want Reviewed-by or something?

-- Pete

