Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9672714DFED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 18:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgA3Rcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 12:32:54 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:45621 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgA3Rcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:32:54 -0500
Received: by mail-lj1-f179.google.com with SMTP id f25so4221989ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 09:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=00IpZxvPCntcVeZvqkk315DeDtL6HDUdprm0PjdbAhw=;
        b=i4Cqgja+2FJtUnJzk2iS+qd97wdl35fVMM6sHgpu9yjlk4+iaxKJWoCg44OWSUlL9A
         ag6izgn9fAQPwdsDoesq93XsoKBeR4VGRU1m200xnPf/HFKVKozSs1308zvKcMOEXDK9
         xTyi+YJQ2PQOEtoagtRMAh9/FdA6n5Qqj8BhOdDehbn1ubMNeZH3ds/wXt/xhFD3cBxv
         PWUzInz2ApgmVzBW5B/eMTbQ7tM2ugM9nB3+ZOSJV4Wx2eT1Syiqr9K7W6h0yGocNLFj
         swGeAEvrZGzQybt040mFmL3Sjk8YRyvBlTIaDmvrc0PsT0pcY4RSQeFBszhcpnr0A+6b
         29kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=00IpZxvPCntcVeZvqkk315DeDtL6HDUdprm0PjdbAhw=;
        b=pRFcu23QSo8SqLtUM6LLZ6X5Q9otKjreKQsai0/Q2siICHSH8C8Bkc3bYG1Onpc1Nz
         kNiNwOlMjV5mrRIJM12fb4JI5+Df6FmVf9sFkSvKbjsTCKo7V7FwA00A/SXrduYzSZuO
         f6WGcv5fTlKk/8oACYnhOTnuw1vxGqNutNHJeiPpaBqeEf/XDNNdvgEleplm1VLf4Gis
         6clFNG8xbHBzzp9j1UANgreT2glnhmBoZbQmbdeF5jNX7KFa9x5x73KKN05uw4i4J6kH
         BoD1JmKVf38yqKqmvH4TFFUoAWwWkyz1xFOB6LHknuN4Re8/y3r+Bf1kqkHnIeFhqCdz
         +fQA==
X-Gm-Message-State: APjAAAWIRZnp22ELwvBjuGB6qGDJ0HD/S2XshHUGL3YVwV2RC4kICz6+
        vgy4Dt/6QtmD0H0CvPGOqWNp2GMYpBUiyLBelsliQTQ=
X-Google-Smtp-Source: APXvYqxMQCkU3qfJB08ACOKKCLqP5cQWGNosD6m0Yd1+9u0kwcfAM0lOnNmLP2tIAn0u1IBkSPeEe+qEQxewOn0oTRI=
X-Received: by 2002:a2e:7818:: with SMTP id t24mr3397650ljc.195.1580405571632;
 Thu, 30 Jan 2020 09:32:51 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date:   Thu, 30 Jan 2020 18:32:40 +0100
Message-ID: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
Subject: 5.6-### doesn't boot
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
my notebook doesn't boot with current kernel. Booting stops right after
displaying "loading initial ramdisk..". No further displays.
Also nothing is wriiten to the logs.

last known good kernel is : vmlinuz-5.5.0-00849-gb0be0eff1a5a
first known bad kernel is : vmlinuz-5.5.0-01154-gc677124e631d

Thanks, J=C3=B6rg
