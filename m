Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4BC41842A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 05:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfEIDi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 23:38:58 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:35738 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfEIDi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 23:38:57 -0400
Received: by mail-io1-f42.google.com with SMTP id p2so525033iol.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 20:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=r3j+ZVm7f8NrC/sBgKDwHbGY3uoVVhO+uMzA3xKyQKs=;
        b=tHueM7cAFIp0/88Jxvi1Atr+l6P4WH+6BrqxUFUIS2UqdeLYj8nNsIZl0v28/ycCFW
         D3nYBdXRxCSrev5+5FF9gmm4LRe7eS+pMfeMfZjITBLI5l0na+C+c+aAiqqDd3Y+8hgh
         6YUhgbeoFNRIY4i2wTqwxRYfMTFff2YxIGTG4RmrwhvHeFylbKKgfSKWkGtLyYAAQVpL
         QrXwAAkKuIjHa780S8ItBcnSCVsf9dpiaR9Mzim91NACnK4rg7EeddJCO7QyB9hz07eD
         Tmmq/G6zfldm3E7x1Tvbf7vPPHzGcc+aSVaJjXC79pPju4w3p5D+maZHt0hSbOxGWf+h
         hRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=r3j+ZVm7f8NrC/sBgKDwHbGY3uoVVhO+uMzA3xKyQKs=;
        b=XwRRT4G8IHJG+RneHa8wBIN09U6xzqY6JdPxxJ7ACCapo3LvosN7NTwgkTABdvN1lm
         TgmS5BFyD3W3YY4kBwSZOn+lceaW4Uiumihns7WvBh2sO12fvUh9/ZDduOn/TGT64dVm
         D2nKeN/vYJUryLqKLcCygl4C/tAsCDQodIvo9d8WPJafm+csPVpwPp8IOFFmXiF4acc1
         8JIi/RmLw3PXAbSnDS3eSGyHSreEJ0AxupCg8S5uN+s3DfARL8wBJuA9N9rvo56JN62a
         UxdW0OJ5Q+LLb0Rm0Tp2yqcbW2DvDlk2CtRBic2fTMXl9KMznZQQo1U9GXuXeoWZtgUD
         T9XQ==
X-Gm-Message-State: APjAAAUDNNlqune6BNK5eXc7AAON8HMObzmlMAw3mI3wBH7MoOuYaUSq
        hgriCGbso1BhFb3s4+RnWMSosLY2ClmgSok+CzHR9Y8j
X-Google-Smtp-Source: APXvYqwiNN4081o5rUjuhprOFbg7qvUmyxWduIvezGwJ/0nqgZ9T6FQRMW6RtRRZyHIrOts4TWmZV1SJkujpteFZF9w=
X-Received: by 2002:a6b:3ac3:: with SMTP id h186mr1051689ioa.63.1557373136361;
 Wed, 08 May 2019 20:38:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:d807:0:0:0:0:0 with HTTP; Wed, 8 May 2019 20:38:55 -0700 (PDT)
From:   Jeffrey Merkey <jeffmerkey@gmail.com>
Date:   Wed, 8 May 2019 21:38:55 -0600
Message-ID: <CA+ekxPVXW-wrSKXoULjJiAJDLNWGRJPe+2u6_YckrW7k2w1LYg@mail.gmail.com>
Subject: Question about dev_queue_xmit and guaranteed packet transmission
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that Linux has been updated on later versions to always
consume the skb in calls to dev_queue_xmit, and may even drop the skb
after returning a return code of NETDEV_TX_OK which seems kind of
broken.  I have an application which requires guaranteed skb
transmission and the following code seems to work well for me if I
call the
netdev->netdev_ops->ndo_start_xmit function directly instead of using
dev_queue_xmit.

Is there a method of calling dev_queue_xmit which guarantees packet
transmission?  The current implementation of dev_queue_xmit used to
return error codes without consuming the skb, which allowed programs
which call it to simply resend the failing skb by calling
dev_queue_xmit again without having to recreate and repopulate the
skb.  There also appears to be no reliable way to know for certain if
dev_queue_xmit even sent a packet since it can at times return
NETDEV_TX_OK then turn around and drop the packet later on.

I have it working calling the ndo_start_xmit driver function directly
which does seem to guarantee  transmission, but would like to know if
there is a way to get guaranteed TX of skb's with dev_queue_xmit.

Jeff
