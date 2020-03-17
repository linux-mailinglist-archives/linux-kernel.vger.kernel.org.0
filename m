Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253A4188CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 18:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgCQRy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 13:54:59 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:35179 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgCQRy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:54:59 -0400
Date:   Tue, 17 Mar 2020 17:54:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1584467697;
        bh=QhRsZkiS34kLl49yJQAowGH2092tzJe/Rf0Sdi2s4ZM=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=cGfJjt1AsGzuodm5NxsbQdCrM4cDb+CE9Fr/8goDC44MLih6MSsI7hHnHSBTYK/Us
         Sbk3FveAuUzR2weUHvtzNxqiBQslNg6pVEPzk3LGJn8lUOTDiLB/JB91SPpjFvRc7G
         vRHaWW1jKXWJeeyoX0XmfnLFxWgfUKCgOBsAWVz8=
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "christian@brauner.io" <christian@brauner.io>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
From:   Simon Ser <contact@emersion.fr>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: SO_PEERCRED and pidfd
Message-ID: <go0RLOS7_DdxyAmfrDR38QPUloZuUtiFdXe2Ey3EkGGuvmW7z18Dvt4fY1qZ1k-Y75-YZSxqVWnZpWRGN7TZ6OPbDczfL7HI25bXLIYq1y4=@emersion.fr>
Feedback-ID: FsVprHBOgyvh0T8bxcZ0CmvJCosWkwVUg658e_lOUQMnA9qynD8O1lGeniuBDfPSkDAUuhiKfOIXUZBfarMyvA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm a Wayland developer and I've been working on protocol security,
which involves identifying the process on the other end of a Unix
socket [1]. This is already done by e.g. D-Bus via the PID, however
this is racy [2].

Getting the PID is done via SO_PEERCRED. Would there be interest in
adding a way to get a pidfd out of a Unix socket to fix the race?

Thanks,

Simon Ser

[1]: https://gitlab.freedesktop.org/wayland/weston/issues/206
[2]: https://github.com/flatpak/flatpak/issues/2995
