Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E2D1422E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2019 21:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfEETwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 May 2019 15:52:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40218 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEETwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 15:52:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id e56so12872639ede.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CLH/j/XeScybyDymyGOfyNq7QLm7Bf/d1bl1PSS5AiY=;
        b=j7eGqnvBn4c5C5qamQLwvmUcEd4Ltqo0k1jw08Cp9fVidEki3sRn0Ri/Nm6SvRWZhV
         8m5IfDMId5tegCu0MrC692BvLpTOPZzUhDmyxYx9h5boo8EVR4fG2PmoSZF1PlpffSpz
         OPz0vXxMBgrBFR1qxtczMLb4hUHd6n4SKkPlV32r+SwEustaTCjkeTtUcozrzTdOMuKp
         RCThTWEh26BKj2v3xhP/aMm5AoxxL6BCUDsmg9tGJoViYAoeP9oatE6Saah9wb2g0c9j
         aDhScPebzmJlaeSjwUYqyf5cWwcInvAN5NhBCqW3855w2Elggmwitog+j7yFK9syBf+t
         efdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=CLH/j/XeScybyDymyGOfyNq7QLm7Bf/d1bl1PSS5AiY=;
        b=qm1LWllrnfLYMzmkMhMmCfgmi4kdC1wmgcDIHwWLjI5KISML0cimmnLumSKSink5bb
         VAStD5GSkvUifEPo3MeNpk5oAiA8CH3KhCoq7nxMRf4mER34ikzGLoSApkpXzZDTFylI
         Zl+cCVWLMxeHl0kT0D8Z2rEOa3DebvgdXI8G7M6DsCShadf14tajN5/wRgP2qW4F9LGE
         wPlidvdtNjzqWYHtFpIPJqRksQsEcy4ctl8SCWiFHeIJ32a4YyBFdZdQR9h5n0EUHAxY
         oZImwQGM9L9+g1/rRDmFX8+bt+QxUM9+NgEzlzL8wtBPu01h/75Z/ndvOFDWakRkIlYl
         jxWQ==
X-Gm-Message-State: APjAAAVY8xeMCNEICa6e8/JRF73c5UF7zr0vTkxsu5BhL+g9wwJiw+rr
        O3zmKMnJ2G8QUqiJ0H8NbUOjNEPo2RNXx/uoORA=
X-Google-Smtp-Source: APXvYqxu5kRwreimuFxg9XPDJwNvspZrnIk6WFSwnofjxbxu98JaEQoibz1vY5h6IuYc2BHEQDhBJZooa5HMhENjHTg=
X-Received: by 2002:a50:8818:: with SMTP id b24mr22196077edb.28.1557085962451;
 Sun, 05 May 2019 12:52:42 -0700 (PDT)
MIME-Version: 1.0
Reply-To: ste1959bury@gmail.com
Received: by 2002:a17:906:25d8:0:0:0:0 with HTTP; Sun, 5 May 2019 12:52:41
 -0700 (PDT)
From:   Steven Utonbury <stev1959bury@gmail.com>
Date:   Sun, 5 May 2019 20:52:41 +0100
X-Google-Sender-Auth: kigvMWrl0M7Lcg5iHwQ9txM3owo
Message-ID: <CACoiVVZyCia+3xzyX9ZJzhndN9HeuFGYL2QK4DSwvC3dgeNYNg@mail.gmail.com>
Subject: =?UTF-8?B?16nXnNeV150=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15TXmdeZLA0KDQrXqdec15fXqteZINec15og15PXldeQItecINen15XXk9edINec15vXnyDXlNeZ
15Qg157Xptek15Qg15zXqdee15XXoiDXntee15og15zXkteR15kg15TXlNek16fXk9eUINep16DX
otep15Ug15HXkdeg16cg15vXkNefDQrXotecINeZ15PXmSDXkNeg15LXqCBNLiDXkNeg15Ag16DX
odeUINec15fXlteV16gg15DXnNeZLg0KDQrXqdec15oNCteh15jXmdeR158NCg==
