Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC51C40EF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 21:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfJATTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 15:19:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36171 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfJATTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 15:19:47 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so50948900iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 12:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=yzM1I7vIj4B6gEhfFYiqYpPbob9CJ1EBRRdKMPdh5bE=;
        b=Fq2Kjs/iX6LiZmnOWFtjhJF6iOi+mLEwLG9UqfKvqvt+zuZzTC0frnyDWgdPYBhILN
         0rYfRYAqppyht16olX1S7MNXRwZnYKs4xoGzRGr/R0JPA+uk/nUK1OpgcZJi+eOYZ0Gy
         /j+/EMkAk2H0Vrefe3yAKzWU8SZJuBz0p161iQwn1Psnkplu57fgo/ypJY8vnsd+7vLH
         NsaoYhdcf1qSlsFNtZAeZcDNJLJnNLt9dd6JZeoJdcQDD67HwCeEX51YklFh0pYwAw43
         tSUstmRqGlEyVX3bFz5EcGzGjRPozuJziRWfYlntIRatYS//OOtcAyhLGN0JbDA9yBSd
         V6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=yzM1I7vIj4B6gEhfFYiqYpPbob9CJ1EBRRdKMPdh5bE=;
        b=BdMJ0NPIygzC5s3di05/L8WmZN/ByL8Oc78qFaIadUDsD9naiipJymIPLFluRyaUcB
         YsCsGAa2G92bkxB6K0ISJq8MwdifqUl2quFoPdWmBgT/9Qmt7boBBkaOvnr8QJCbD5wV
         HUbNv5ySxf65ks8ZWo3jq24jZWGmf3+OConwxMDLBGqHrovunLgn+Dp3NHQzf9fz5CtP
         B6KguQtsI93YfwWNOjkSpoOJzZ7SLyXTcUwEOEojqoLUk8pLbhTFVQDz+o+lJ/kN0rv2
         JSTK4WFg0B0bkDY6pee/A9NyfzggTkeuHgbP893mmeF1MXL6baQpv53Z1jNMDaz0jpCb
         HCnQ==
X-Gm-Message-State: APjAAAXs8WUQ1aiuFeLdkdj/56slh1s3dLmHPsqHHMvnD5Op1aAX/MoK
        W3mw3SWrOGM+ZIxsnKu+hPd9FvZE7/Pb83JK6Pw=
X-Google-Smtp-Source: APXvYqwj6+dkexMIZW0z1lF2oT1ert7qizLmWTrDdI+F9eZ9nrcS0njkimgo67FVTEqnNy/AXzwY0WUT8eH+S9mXn04=
X-Received: by 2002:a5d:83d3:: with SMTP id u19mr3825574ior.299.1569957586369;
 Tue, 01 Oct 2019 12:19:46 -0700 (PDT)
MIME-Version: 1.0
Reply-To: akgazshak@gmail.com
Received: by 2002:a4f:cd99:0:0:0:0:0 with HTTP; Tue, 1 Oct 2019 12:19:42 -0700 (PDT)
From:   =?UTF-8?Q?=C4=B0shak_BURAKGAZI?= <akgazishak@gmail.com>
Date:   Tue, 1 Oct 2019 12:19:42 -0700
X-Google-Sender-Auth: _AZYxd5keeDL9KkcpSAIVD062lc
Message-ID: <CAEhAppFSyE5PU5x4VEvS9fqjRTE=s6mQFBAuSO7O6Ks46b-NDg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15nXldedINeY15XXkSwNCg0K15HXkden16nXlCDXl9ep15XXkSDXnteQ15XXkyDXqdeg15PXkdeo
INeV16DXk9eV158g15HXmdeX16Eg15zXnteb16rXkSDXqdep15zXl9eq15kg15DXnNeZ15og15zX
pNeg15kg15vXnyDXotecINeU15TXpNen15PXlCDXlNeW15Ug15vXkNefLg0KDQrXkNeZ16nXkNen
Lg0K
