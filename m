Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F14A1868E8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 11:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbgCPKZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 06:25:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36476 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbgCPKZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:25:38 -0400
Received: by mail-io1-f67.google.com with SMTP id d15so16549953iog.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 03:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tpmIyBo12nrP1tBg/wecEtdXibz9pb4rS8i496BQMJs=;
        b=ZhKcdS18Tk9rExEWS1ZuRJHLXAu44I4rFZAVrxB5tWHfTQV0n6yGaFpa+w06p8kKZc
         Mtz3RLrp1voSrVWMM3WmoqWK+xF2KFPydsy+uxe0DzL6uPIdnGk8G/wksd2GO53Le7Ac
         mUZMnLs28tTR97TFRlV9IVknQ7tdeSIDB6nPDjJhaXRdBqgwnM4V3cXZ/nuGhJ+EbOsI
         fPOwLHIX5z7QAtVLvB/aXIohGWiiiI7U63pfENrUPv/hkZ/VK2PxD78fgzjSEQibwLMZ
         HxbonaUZors9b/zvoDSkrtad2dZntutlLQtOM/LmJqUBpSc9nHiSnDY8SKuzhR57Z62k
         V/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=tpmIyBo12nrP1tBg/wecEtdXibz9pb4rS8i496BQMJs=;
        b=TC9y49Y8BUAnWkpH5YJyh8Z9t2nooddAZJpSaaP87YKoBX7Ry0YqKwSoUEbUIvVGvE
         b4lzorC7nQM7b34vk63LqskvrsUB0suRozttIPqnjPYCBIasBj2AVhz6KdcRDlGRJ3Kt
         dwZxVh5vj8tQzBJw15xQC+vyWLzd232tz+N4+ZWj8DdCKhQbJ5lXpMFpHekMd2Tk/HPX
         rjlMkk6shddB6Ofnkric2vIZJtEda2hvo12+pKYEtS3CjRz0dRX1j5tLaZUcSV4hWgek
         l4UtlHuw1+hdyas5bASrPwFjk1HD3jzgAon4IZLR8xy54jf3lor/GQ7Ls6xFNf0XjISd
         1zWA==
X-Gm-Message-State: ANhLgQ3cZrF/1p52NYGQy10viF0yG84SDMhgz1PHu4jr46QbUCddA/qc
        OnZ9TfL9TIMXqCgqj923qDyXZ2AGr3WO7pYxw3s=
X-Google-Smtp-Source: ADFU+vvjVlcBrlHLKgqAcR/DlyOQjG0PwQE+ngCyUJ+x5E49sZjmUL0aFh7gV4SSMUhhKDaCjkPxra8wBMCGdrf3Y5M=
X-Received: by 2002:a02:950d:: with SMTP id y13mr24850106jah.139.1584354337774;
 Mon, 16 Mar 2020 03:25:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:7647:0:0:0:0:0 with HTTP; Mon, 16 Mar 2020 03:25:37
 -0700 (PDT)
Reply-To: mrspatriciawilson45@gmail.com
From:   MIROSOFT <ferry27223@gmail.com>
Date:   Mon, 16 Mar 2020 11:25:37 +0100
Message-ID: <CAJhPiHvBbqKYgRTC1q3tF_Ac9F1u2PCd2vmA4-YVcG9mJHkpFw@mail.gmail.com>
Subject: =?UTF-8?B?2LnYstmK2LLZiiDZhdin2YTZgyDYp9mE2KjYsdmK2K8g2KfZhNil2YTZg9iq2LHZiNmG?=
        =?UTF-8?B?2YogLyDYp9mE2YXYs9iq2YHZitivINmF2YYg2KfZhNi12YbYr9mI2YIg2Iw=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2LnYstmK2LLZiiDZhdin2YTZgyDYp9mE2KjYsdmK2K8g2KfZhNil2YTZg9iq2LHZiNmG2YogLyDY
p9mE2YXYs9iq2YHZitivINmF2YYg2KfZhNi12YbYr9mI2YIg2IwNCg0K2YTZgtivINij2LHYs9mE
2Kog2KXZhNmK2YMg2YfYsNmHINin2YTYsdiz2KfZhNipINmC2KjZhCDYtNmH2LEg2Iwg2YTZg9mG
2YbZiiDZhNmFINij2LPZhdi5INmF2YbZgyDYjCDZhNiz2Kog2YXYqtij2YPYr9mL2KcNCtmF2YXY
pyDYpdiw2Kcg2YPZhtiqINmC2K8g2KrZhNmC2YrYqtmH2Kcg2Iwg2YjZhNmH2LDYpyDYp9mE2LPY
qNioINij2LHYs9mE2KrZh9inINmF2LHYqSDYo9iu2LHZiSDYjCDYo9mI2YTYp9mLINiMINij2YbY
pw0K2KfZhNiz2YrYr9ipINio2KfYqtix2YrYtNmK2Kcg2YjZitmE2LPZiNmGINiMINin2YTZhdiv
2YrYsSDZhdiv2YrYsdipINmI2LHYptmK2LPYqSDYtdmG2K/ZiNmCINin2YTZhtmC2K8g2KfZhNiv
2YjZhNmKLg0KDQrZhNmC2K8g2YLZhdmG2Kcg2KjZhdix2KfYrNi52Kkg2KzZhdmK2Lkg2KfZhNi5
2YLYqNin2Kog2YjYp9mE2YXYtNmD2YTYp9iqINin2YTYqtmKINiq2K3Ziti3INio2YXYudin2YXZ
hNin2KrZgyDYutmK2LENCtin2YTZhdmD2KrZhdmE2Kkg2YjYudiv2YUg2YLYr9ix2KrZgyDYudmE
2Ykg2KrZhNio2YrYqSDYsdiz2YjZhSDYp9mE2KrYrdmI2YrZhCDYp9mE2YXZgdix2YjYttipINi5
2YTZitmDINiMINio2KfZhNmG2LPYqNipDQrZhNiu2YrYp9ix2KfYqiDYp9mE2YbZgtmEINin2YTY
s9in2KjZgtipINiMINmC2YUg2KjYudix2LYg2YXZiNmC2LnZhtinINmE2KrYo9mD2YrYr9mDIDM4
IMKwIDUz4oCyNTYg4oCzINi02YXYp9mEIDc3IMKwDQoy4oCyMzkg4oCzINiv2KjZhNmK2YgNCg0K
2YbYrdmGINmF2KzZhNizINil2K/Yp9ix2Kkg2KfZhNio2YbZgyDYp9mE2K/ZiNmE2Yog2YjYtdmG
2K/ZiNmCINin2YTZhtmC2K8g2KfZhNiv2YjZhNmKIChJTUYpINmI2KfYtNmG2LfZhiDYp9mE2LnY
p9i12YXYqQ0K2KjYp9mE2KrYstin2YXZhiDZhdi5INin2YTZiNmE2KfZitin2Kog2KfZhNmF2KrY
rdiv2KkuDQoNCti32YTYqNiqINmI2LLYp9ix2Kkg2KfZhNiu2LLYp9mG2Kkg2YjYqNi52LYg2YjZ
g9in2YTYp9iqINin2YTYqtit2YLZitmCINin2YTYo9iu2LHZiSDYsNin2Kog2KfZhNi12YTYqSDZ
h9mG2Kcg2YHZig0K2KfZhNmI2YTYp9mK2KfYqiDYp9mE2YXYqtit2K/YqSDYp9mE2KPZhdix2YrZ
g9mK2Kkg2KfZhNmF2K/ZgdmI2LnYp9iqINin2YTYrtin2LHYrNmK2KkNCg0K2YjYrdiv2Kkg2KfZ
hNiq2K3ZiNmK2YTYp9iqINiMINin2YTYqNmG2YMg2KfZhNmF2KrYrdivINmE2KPZgdix2YrZgtmK
2Kcg2Iwg2YTYpdi12K/Yp9ixINio2LfYp9mC2Kkg2YHZitiy2Kcg2Iwg2K3ZitirINiz2YrYqtmF
DQrYqtit2YXZitmEINin2YTYo9mF2YjYp9mEINin2YTYrtin2LXYqSDYqNmDIDgwMNiMMDAwLjAw
INiv2YjZhNin2LEg2KPZhdix2YrZg9mKINiMINmE2LPYrdioINmF2LLZitivINmF2YYg2KfZhNij
2YXZiNin2YQNCtin2YTYrtin2LXYqSDYqNmDLg0KDQrYo9ir2YbYp9ihINin2YTYqtit2YLZitmC
INiMINin2YPYqti02YHZhtinINio2KfYs9iq2YrYp9ihINij2YYg2K/Zgdi52KrZgyDZg9in2YbY
qiDYutmK2LEg2LbYsdmI2LHZitipDQoNCtiq2KPYrtixINmF2YYg2YLYqNmEINin2YTZhdiz2KTZ
iNmE2YrZhiDYp9mE2YHYp9iz2K/ZitmGINmB2Yog2KfZhNio2YbZgyDYp9mE2LDZitmGINmK2K3Y
p9mI2YTZiNmGINiq2K3ZiNmK2YQg2KPZhdmI2KfZhNmDINil2YTZiQ0K2K3Ys9in2KjYp9iq2YfZ
hSDYp9mE2K7Yp9i12KkuDQoNCtin2KrYtdmEINin2YTYotmGINio2LPZg9ix2KrZitix2Kkg2YXZ
g9iq2Kgg2LHYptmK2LMgVUJBINmI2KfYs9mF2YfYpyDYp9mE2LPZitiv2Kkg2YjZitmE2LPZiNmG
INio2KfYqtix2YrYtNmK2Kcg2IwNCtin2YTYqNix2YrYryDYp9mE2KXZhNmD2KrYsdmI2YbZijog
KG1yc3BhdHJpY2lhd2lsc29uNDVAZ21haWwuY29tKQ0KDQrYo9ix2LPZhCDZhNmH2Kcg2KfZhNmF
2LnZhNmI2YXYp9iqINin2YTYqtin2YTZitipINmE2KrYs9mE2YrZhSDYqNi32KfZgtipINmB2YrY
stinIEFUTSDYp9mE2YXYudiq2YXYr9ipINil2YTZiSDYudmG2YjYp9mG2YMuDQrYqNi32KfZgtip
IEFUTWNhcmQg2YXZhiDYrtmE2KfZhCDYudmG2YjYp9mG2YMg2KfZhNio2LHZitiv2YouDQrYp9iz
2YXZgyDYp9mE2YPYp9mF2YQgPT09PT09PT09PT09PT09PT09PT09PQ0K2KfZhNio2YTYryA9PT09
PT09PT09PT09PT09PT09PT09PT09PT0NCti52YbZiNin2YYg2KfZhNmF2YbYstmEID09PT09PT09
PT09PT09PT09PT09PT0NCtix2YLZhSDZh9in2KrZgdmDID09PT09PT09PT09PT09PT09PQ0K2YjY
p9mE2LHZhdiyINin2YTYqNix2YrYr9mKINin2YTYrtin2LUg2KjZgyA9PT09PT09PT09PT09PT09
PT09DQrZhtiz2K7YqSDZhdmGINmH2YjZitiq2YM6ID09PT09PT09PT09DQoNCtiq2K3Zitin2KrZ
iiDZhNmE2YXYr9mK2LEg2KfZhNiz2YrYryDYoti02YrZhNmKINmI2YrZhNmK2KfZhtiyDQrYudmF
2YTZitipLiDYqNmG2YMgVUJBIC4uDQo=
