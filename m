Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3A325E48
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 08:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfEVGqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 02:46:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37612 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfEVGqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 02:46:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id e15so889718wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 23:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=guV7wGssr3wZ4yohn9z4wdxCv2p6CIJkNUyHwUbK5VI=;
        b=sT8Vh1hUK4F2HcQYM3jhA/ErtnwlNJc6EkwkSMtlpGvroQ5Z12jWVZ6G8miN3+gBYf
         GCpDfvlg0+68Mym7PhLYhbaRKVSTSS4WywtXxRHYYoRaBAMgAvl+SVytV02Wo1Jm17DR
         oaw1U0/+eE7Ub6cGVmHrX7Haj5luONjW7yQuuV8zazN1wMylWXSxkL6/oZH3tmdH7ogk
         Gf1oyHi3UY2O4a04H97YpKwXoQjc/gve8N3L2m7mZbnOLA2T76v1z7vliqdE7LBuhGUW
         kHIEL4DlWIYwN1HS8vuFiNuLjZ8SxPmXI5RN9HmPox0BkS+b9t4ftcfJojVyh1Q4W0Jb
         8x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=guV7wGssr3wZ4yohn9z4wdxCv2p6CIJkNUyHwUbK5VI=;
        b=PnPD256Iw2StBtXO3siVOSpeKMpLZVXW6l5xVXErcRzFRnkeeARb0XPw/g9yZ2+JLr
         9xz9xsixXm7A7KUg6EfH4245hgxaT9hT0v5Xt/9JSq5P6TzQ9swqUmdwT74NxL8hNQEy
         85Oq69D5hzSAuBWotf62YXA5kxAldG2smPfAAZu0T4k/GZdb4+ne4slmFmV8kPgY0pSV
         uQtXU4/6E5GzsFsIbfzeS91UtdaufuTaI45eL4MiAyBXfpVX9R5S6cIl04l6t496R4jb
         hkikGFJYNrmx3vSU7InjTFj1kd+G1Ti+22rqrGbCSHR4wxm02u80hhRLzHO/axnBejxj
         xJKw==
X-Gm-Message-State: APjAAAVqS7VSvDu67MpZJSrFW2vRC27EBBu3JPfZCtbJuM/ekpOwqcAY
        yIGzVqMDlcFLUWhFYWyPvRdnBMbMwMU=
X-Google-Smtp-Source: APXvYqxJu++dPH01zVvist9igwZEBq8ExUzUEEehwFHM+eURyaV44aWdq2g7Ej2IAk9rvk4PvXwFHA==
X-Received: by 2002:adf:fb47:: with SMTP id c7mr3157360wrs.116.1558507609114;
        Tue, 21 May 2019 23:46:49 -0700 (PDT)
Received: from archlinux ([151.235.77.44])
        by smtp.gmail.com with ESMTPSA id v11sm293962wrr.87.2019.05.21.23.46.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 23:46:48 -0700 (PDT)
Message-ID: <cb9c41cf84bc1e2db5361c2440f6c42e5533f37e.camel@gmail.com>
Subject: 
From:   Mohammadreza Abdollahzadeh <morealaz@gmail.com>
To:     linux-kernel@vger.kernel.org
Date:   Wed, 22 May 2019 11:16:45 +0430
Content-Type: text/plain
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unsubscribe morealaz@gmail.com

