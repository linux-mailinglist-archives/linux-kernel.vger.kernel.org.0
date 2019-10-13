Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08759D5666
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfJMNi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Oct 2019 09:38:59 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:44099 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbfJMNi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 09:38:59 -0400
Received: by mail-qt1-f178.google.com with SMTP id u40so21291681qth.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flameeyes-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5bt0J3PaiHt1xAWPqiCf2mxksXkVvwFrzMFCAzZUrxM=;
        b=l8APlltH/qtIhTEL2YWiWhEAJup+fqOHPEUoXs1Lfw8PRXml+I3zWxzZXcXizc2BlE
         Pfg/6RJ/fXVWa4otnNbh63tdKhJ9aIKWhn5OdjNKMPr8zAUWyfpLPFLeQF7uGZXdwG17
         wH6wtXmwzOoUuTd1KnWsNBYb3Kqgmpwyk+288z46NxLOo+7pivVPwtFKjOAtr+KvlBmq
         emYXwOvDtaPwkuFRV9XXRQ8bH/wffdX8l6KE+xXG3WUJslIZp9mqsoQSgjb2WR1+aToO
         fADEXcb1ifXUAt4j726S3pimQTsszLdDoWC0/qGjYhu8sxdlPVsvFzX0nJP8GygMWKZz
         ES/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5bt0J3PaiHt1xAWPqiCf2mxksXkVvwFrzMFCAzZUrxM=;
        b=Sk6uXaERRo9YYKMwUT3KTzBF1TS0LGE9263geDaA6fJIoTP/Z+JaumXbHqRRgYHQ7k
         W18LvNHYqNNvjMAfdfThe9KiJrRzxiSfdZFVC7l3w9nlADOproWx8/6ZCcsVxp4K/OT8
         n/mKKVlUYOB6LLV8XRFF0pqCk4NDWwrKhhuJYHzj5AI9BPZ1xQMxJ1JaOAaIwj0SMg2z
         0vU1mu0aRAvxA23CpNaWzoBTIBgHbFHcYEWfWq5NG2auBIKr0U9+k47xQC0SRnvQ9T9x
         VHFwQFG6sUg8Jtf/OlaThhp7lgttMyhrwJvMp6CoiFfD7fMxm0G8VHi/qoYG+1gTszbA
         W5Yw==
X-Gm-Message-State: APjAAAVoQHpRZslMcAzV0WzSpBD+57NmESag4B9PNYvg/etNTK2SPJgl
        HuXz1RWoyIQiLSeobtk+J+gHc999o+jnbkezca1aCzPd11A=
X-Google-Smtp-Source: APXvYqyVLr23BHOO9fIm7w9yG2U2UjxNW7xboLKqaZzHAhNDqWBscuPjVPRQHUx7xdpmhRfBC6m9k9k2jZ10FUlUSAE=
X-Received: by 2002:a0c:f3c1:: with SMTP id f1mr27167345qvm.165.1570973937339;
 Sun, 13 Oct 2019 06:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190826151640.5036-1-flameeyes@flameeyes.com>
In-Reply-To: <20190826151640.5036-1-flameeyes@flameeyes.com>
From:   =?UTF-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.com>
Date:   Sun, 13 Oct 2019 14:38:46 +0100
Message-ID: <CAHcsgXTM2ry--LDO=rMg54nYRF+YeVMeoCpig=fEAyrMDiLfcw@mail.gmail.com>
Subject: Re: cdrom: debug info changes, Beurer glucometer support
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 4:16 PM Diego Elio Petten=C3=B2
<flameeyes@flameeyes.com> wrote:
> I've been hacking around the cdrom driver so that I could get Linux to
> mount and access the virtual CD device used by the Beurer GL50 evo
> glucometer. The device is fairly quirky and goes into a reset cycle on a
> vanilla kernel.

Hi Jens, any chance you could take a look at these patches? I'm not
making much progress on figuring out the higher level protocol of the
meter, and it would be easier if I could connect it directly to my
machine, rather than having to jump through VMs :(

Thanks!
