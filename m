Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B70C4245
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 23:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfJAVDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 17:03:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32944 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfJAVDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 17:03:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so14887296ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xVo2gsxOzB1y1F6uA9pSYBqYOxCHf1hH/X+C/rOrXOQ=;
        b=A8TilNrna3W/vwzhaXOeIP05g2CPlor74h/JUTsGIz1ZYtqYtlkish1SGi5AjAmQaD
         erpg+zhIjqbjv9FHU3CgWOBSNuaAFq8qVerypoI/q0kOMx7duOjFpTMA7vKRBOQIfCNk
         /YmmfkvvA3kqeF5zi7WZwQxYCbOmqAx19N1XLjLlyEeLB+ogW3MUK1HfOtafYhkSGWtq
         IF76dDKohbxaZrBCr4nzL1YSc5XRz2TG84uEBkVTkFtLjXkh9fKsCIw3OCM7l9QX1nS8
         zoBH65HB7WU6H++TkGZnk/icUglg/mZY6OACMG1IiahnlJ7enT/qndhk0Xjx3C+9Yauq
         cY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=xVo2gsxOzB1y1F6uA9pSYBqYOxCHf1hH/X+C/rOrXOQ=;
        b=jvQQjrbI5xVXrPWfor8ac4YvJ/gWuwDNcjomhmq8xAX6ZO9CHFuNOEM3jWKMr2eS+P
         W6CeCQnHF5hEZEJaG4/cy01u0bb6LiuPgUpjibHq0/oKPACAXQe0IRtbj4rIf+7VZnZo
         0yq5pm2R2TwgdKm4807iKvqRzCwV4cJLnMmyJLD25OQ8XIRUtqtMNdCajmjlj4Tgtq8e
         PPEfFjBS+qTvhhd4edZjhDPBQG7jSWj6Re9nleXITSLZMinIJ50MwZ/TV4A8Asu474u5
         /tnxxiwsCcSrlBZeYON/xi/bqFTASKF0VqfGsncSwOKTWoaBV3iG1rKCVZxOVl/c7pbh
         Ayqg==
X-Gm-Message-State: APjAAAUBFoGDWfQswbKYjRQfUNtE73OsWmiXRX426819uiJYtOeS9lNP
        TQCfa/973LjkIR7UkcVbk9v0SiM0Bugo0PLUE2M=
X-Google-Smtp-Source: APXvYqxKLOud/cbNRFAITb36dRw0nD3B8bbTGKUXIuBFjCAYpNd8pHB3dN1B3aPmDAKyQxXvTcuS+4OYIQmL9TUXbCY=
X-Received: by 2002:a2e:7d19:: with SMTP id y25mr17565558ljc.177.1569963802426;
 Tue, 01 Oct 2019 14:03:22 -0700 (PDT)
MIME-Version: 1.0
Reply-To: akgazshak@gmail.com
Received: by 2002:a19:2297:0:0:0:0:0 with HTTP; Tue, 1 Oct 2019 14:03:20 -0700 (PDT)
From:   =?UTF-8?Q?=C4=B0shak_BURAKGAZI?= <akgazishak@gmail.com>
Date:   Tue, 1 Oct 2019 14:03:20 -0700
X-Google-Sender-Auth: LHSknCOoU3m0xON44vFw1i_emBU
Message-ID: <CAEgzzmjAqJA7ZGEu7pHTWqe4qfC4q2ju8YoLTDU-dSGpzGD80w@mail.gmail.com>
Subject: hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16LXqNeRINeY15XXkSwNCg0K15HXkden16nXlCDXl9ep15XXkSDXnteQ15XXkyDXqdeg15PXkdeo
INeV16DXk9eV158g15HXmdeX16Eg15zXnteb16rXkSDXqdep15zXl9eq15kg15zXmiDXp9eV15PX
nSDXotecINeU15TXpNen15PXlCDXlNeW15Ug15vXkNefLg0KDQrXkNeZ16nXkNenLg0K
