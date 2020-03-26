Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797D5193639
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 03:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgCZC4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 22:56:53 -0400
Received: from mail-yb1-f170.google.com ([209.85.219.170]:43548 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCZC4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 22:56:52 -0400
Received: by mail-yb1-f170.google.com with SMTP id o70so2420999ybg.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 19:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=S0MCd00hiBhu8IoAyKrnUIhRxVoguqUOo5RV8MMGToY=;
        b=m8X8VCsd2sQNfwwgM2l4Wp/B8DXJ3vdm3Cf7OopNk8UwxepjDhTQxchpB3ek9VoEzG
         DuG/l06pK0Je22N5qF2bTpU0BpiPiAWyLIbpj1hHpbGpnErWOySUTzHKkOP/PlyKMEQX
         DYO8EquYAi/s+A9bTCIXbK2aa25c2YYfp7Mt76T+kazm/GrA7X29YHvPkmcyUcWLV53q
         pwXVlYRSd60779BsWBgHD9NYJbWIVEd2ZN2mV/ngiLApWShM8BjmeeooMxcdOipImFU/
         Q48JBxl/WsN8gUAsBZT4ZFoa+uWiPMf3fDpE6Tma259quYhBJvLbO3U/nQm2Lys7HYUa
         DCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=S0MCd00hiBhu8IoAyKrnUIhRxVoguqUOo5RV8MMGToY=;
        b=s3aSLzy/Cy3bPYKGX2l2zBjTT0ls1j5IRk9l22R3wiJh7PK2oBsXK66slEzpmawi55
         wWpu/MSOMmExknCOT1KgfYx0ZG7hDn/hfATN+3MPfU/TeoeJQK7EE5l9ygi27Yo4lt+u
         6qrbECEeX/+UVDk48PvX7KX0kD0SW+GvSb5gQQCfr7nq9DYf77a8BsGmKJ4NK1UJ2FMV
         w6YQGw7LEqNhZU3d4/jUX3qad+B3QiYG8hs2VC25Mv9G9TMr5NpIhaPbAiHCOaCTnumV
         O1TcgaO/VSrKPIvi4LpW/ECkkYpqMMjwyT/xtNv4vRm+zMR3KdPHqG9JrXzOnxG/Ans+
         w50Q==
X-Gm-Message-State: ANhLgQ1ew9s3EZTFiiRNskbJ+3KajA0LLTry2ACDfUuEN98456TVA8d6
        9tGwQElrDuIYBY6QxKgVtLU22CGj3kct/9Naoj56APK36AI=
X-Google-Smtp-Source: ADFU+vsQYEblPiKc80eaK8adRNcEBrLj85agt31kCXVvFxIrHWES8AzBjaYVayc4VxAEDGTOsAqoJVAKHnvs0nZFMPc=
X-Received: by 2002:a25:aa69:: with SMTP id s96mr10418528ybi.85.1585191411175;
 Wed, 25 Mar 2020 19:56:51 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 25 Mar 2020 21:56:40 -0500
Message-ID: <CAH2r5ms4+GyqD3VJNRXXwDsPnEWvWpqEPXqm+UiR92myiAVUww@mail.gmail.com>
Subject: Using QUIC from kernel drivers
To:     quic@ietf.org, LKML <linux-kernel@vger.kernel.org>
Cc:     ronnie sahlberg <ronniesahlberg@gmail.com>,
        Jeremy Allison <jra@samba.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have been trying to experiment with using QUIC for access to
network file systems (Samba, Windows etc. over SMB3.1.1 over QUIC) but
cifs.ko is a kernel driver.

Are there any examples of using QUIC from Linux kernel drivers? Or
suggestions on how to do this (I didn't see any QUIC kernel drivers
yet from a "git grep" of 5.6-rc7).  Presumably worst case scenario is
that the kernel driver could upcall for the authentication phase, and
then presumably there is a better way to avoid upcalls for the rest.

There were some details on how Windows did this at the annual large
Storage Developer Conference (https://youtu.be/xUvfjZXIu9E) but was
wondering if any progress with figuring out how kernel drivers can use
QUIC.

-- 
Thanks,

Steve
