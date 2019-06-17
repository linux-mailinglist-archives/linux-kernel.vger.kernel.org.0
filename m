Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFAB848E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 21:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfFQT0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 15:26:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39950 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfFQT0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:26:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so11267275wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OOw5x/J4wgJdDk11jX3bqqbWlKZgew2Sog0cRH396k8=;
        b=o5c10gtWHlSNRl3/LiUvQ1cQ+z8kJuurDcVFdsIrkLY/cZz70eHHgNJfYIOPV2j3hG
         7uIKUoFkcgGvVHfuBNqfzmZ972ASUQ2UObb8G0uOlsIEzB3KLgsHl3qKrpjEmstiRth2
         CewjyMet1ebsrXQKT0aRgW8LTuZtzjf/+u0A21o/7zbL7ah7NqMQSySCYR1jeJEGWWfq
         ZijOUJWPmsOv5Qf5Bo0pIv50sHgkYC1Shs4pn6H1oykiUAJEBb6TofPigDmg4X46Hs8s
         nYvc3Dg24JQUezxoO0QR1Gg3kWgW6ph+1+uvcTp8tEhfrNjIK+T6a8T/QQkgv/az2CvW
         ftnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=OOw5x/J4wgJdDk11jX3bqqbWlKZgew2Sog0cRH396k8=;
        b=IV2sJp0C245inCsivxA9f3q42jJaJ5hzDuE2HUJLWalUDNwd7qQ0PmxcGK+Kvh/3+p
         gWq0PN3s+sUqyezDLZOsgDJ9B8wA/R/PGAMWwI2xSdUVJeg4KOhq/Riaw1UR2rQH7ko3
         W8amG6qBlQ6Y32GD/Kfyohu7kF0UvGta00Qz2nlqPtrbqd94vbkCjvFVw9+AhBFOB0vW
         kywGBAPMPkUEVblZ0MM6JeOQ3njF8CXCc6HaSsR+CH86UED5a5AhQItxMj/4oLznUKK1
         7PfEpHoWS8937cgvyjlSLDE3ArixE2pEKk4cgzs70ES9qeEkJopyo6VMGzjkvfTyEKor
         UK9Q==
X-Gm-Message-State: APjAAAWi3McRkRiMAZKNWcPPgQkEALGMaS5oq1HIsB0knyb0NjdrJxzJ
        rxd0rlPVJ9UkJpIfXhQsXtukg4AWAsklQa474hA=
X-Google-Smtp-Source: APXvYqzurknXhmjwvrJIyz7h0WqkiABR9N7lx1f44zjc7WNgmeUJ5mOVHNqk8Em0gdg81a+M1QsXxm8iDqoju6vH0dw=
X-Received: by 2002:adf:9dcc:: with SMTP id q12mr8759894wre.6.1560799595225;
 Mon, 17 Jun 2019 12:26:35 -0700 (PDT)
MIME-Version: 1.0
Reply-To: ste1959bury@gmail.com
Received: by 2002:a5d:42c2:0:0:0:0:0 with HTTP; Mon, 17 Jun 2019 12:26:32
 -0700 (PDT)
From:   Steven Utonbury <stev1959bury@gmail.com>
Date:   Mon, 17 Jun 2019 20:26:32 +0100
X-Google-Sender-Auth: WBHMDGy9drUlZvBuo0JGvHM1jLc
Message-ID: <CAMZQ8uChwAK0Mhg=GC3u2Ge6DtGAcNj=c6xLnNMpwO85tKF3og@mail.gmail.com>
Subject: =?UTF-8?B?16nXnNeV150=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16nXnNeV150sDQoNCteQ157XldeoINec15kg16nXp9eZ15HXnNeqINeQ16og15TXlNem16LXlCDX
qdep15zXl9eq15kg15DXnNeZ15og15HXoNeV15LXoiDXnNeU16TXp9eT15Qg16nXnCDXlNec16fX
ldeXINeU157XkNeV15fXqNeqINep15zXmSwNCteU15XXk9eiINec15kg15DXnSDXp9eZ15HXnNeq
INeQ15XXqteUINeV15DXqiDXm9eV15XXoNeV16rXmdeaINeR16LXodenINeV15vXk9eZINec16rX
qiDXnNeaINeQ16og15TXnteZ15PXoiDXldeb15nXpteTDQrXoNeZ16rXnyDXnNeU16nXmdeSINeZ
16LXkyDXlteULiDXoNeh15Qg15XXl9eW15XXqCDXkNec15kuDQoNCteR15HXqNeb15QNCteh15jX
mdeR158NCg==
