Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E57BA3B60F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 15:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390412AbfFJNb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 09:31:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36191 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390335AbfFJNb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 09:31:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id k21so11217943edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 06:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zHz2UJxUdh3rVwhA5EFSYkJKTVOd6ZuZb4Wud/lpDSg=;
        b=fWc2SKw1ytoddHPkJvvcSCWimEyww8DZXnR3w0ZQ06XS60Z1GigSyIoC+r1b647/HV
         RkNhOyqIO8k6DbUPZLA/Ic9jVjtlqbRvCTTRKLDBhH1DdNp1KY/41IL57yxUk975TSmV
         eqIiNIu0lukSKgHpUN/M7h03J+TSpCBk0GhgRizA1FCoemEX0+A25YqvoMFJB9Dd0DG1
         yGciQhTTnfoyi7lj4Chtf8oMEHhc3MeYd7Ob0VtjhtdImUdaP55aRmY9h9GWazCWRZ4t
         wjFpOU9FHEh3qV5Tji0LYfe1dTrcwCoc1kE/yLzho8ekU3meKYKxOx3rtLj/bVGvP3Rr
         93Qg==
X-Gm-Message-State: APjAAAUDfg+4DyoqSAImf45OftxrWpf4tO15UkMvagxwmu9F0lAVKybg
        qezVyk78WCuHtakKWPQ/PE1tyRO7EIg=
X-Google-Smtp-Source: APXvYqy7j6yOiZLfwFmeashZGQlsG1+Ytyj3AZ7oYct+ix5JgEUtL2nkKriE4NohbcrK4qFIe941ww==
X-Received: by 2002:a50:94a2:: with SMTP id s31mr33340960eda.290.1560173516809;
        Mon, 10 Jun 2019 06:31:56 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id f9sm1790236ejk.73.2019.06.10.06.31.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 06:31:56 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>
From:   Hans de Goede <hdegoede@redhat.com>
Cc:     linux-bluetooth@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Bluetooth regression breaking BT connection for all 2.0 and older
 devices in 5.0.15+, 5.1.x and master
Message-ID: <af8cf6f4-4979-2f6f-68ed-e5b368b17ec7@redhat.com>
Date:   Mon, 10 Jun 2019 15:31:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

First of all this is a known issue and it seems a fix is in the works,
but what I do not understand is why the commit causing this has not
simply been reverted until the fix is done, esp. for the 5.0.x
stable series where this was introduced in 5.0.15.

The problem I'm talking about is commit d5bb334a8e17 ("Bluetooth: Align
minimum encryption key size for LE and BR/EDR connections"):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5bb334a8e171b262e48f378bd2096c0ea458265
basically completely breaking all somewhat older (and some current cheap
no-name) bluetooth devices:

A revert of this was first proposed on May 22nd:
https://lore.kernel.org/netdev/CA+E=qVfopSA90vG2Kkh+XzdYdNn=M-hJN_AptW=R+B5v3HB9eA@mail.gmail.com/T/
We are 18 days further now and this problem still exists, including in the
5.0.15+ and 5.1.x stable kernels.

A solution has been suggested: https://lore.kernel.org/linux-bluetooth/20190522070540.48895-1-marcel@holtmann.org/T/#u
and at least the Fedora 5.1.4+ kernels now carry this as a temporary fix,
but as of today I do not see a fix nor a revert in Torvald's tree yet and
neither does there seem to be any fix in the 5.0.x and 5.1.x stable series.

In the mean time we are getting a lot of bug reports about this:
https://bugzilla.kernel.org/show_bug.cgi?id=203643
https://bugzilla.redhat.com/show_bug.cgi?id=1711468
https://bugzilla.redhat.com/show_bug.cgi?id=1713871
https://bugzilla.redhat.com/show_bug.cgi?id=1713980

And some reporters:
https://bugzilla.redhat.com/show_bug.cgi?id=1713871#c4
Are indicating that the Fedora kernels with the workaround included
still do not work...

As such I would like to suggest that we just revert the troublesome
commit for now and re-add it when we have a proper fix.

Regards,

Hans


