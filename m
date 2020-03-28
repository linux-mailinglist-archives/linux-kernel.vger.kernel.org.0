Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B8819674F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 17:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgC1Qaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 12:30:46 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17461 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgC1Qaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:30:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585413038; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=kV3qt3YBKrbyMMMO2IkDxAuJBhAISaVrcpfjXkCRxFHeNAWzn4lE2WshIRa3FqC38rL74rZgwzx1+QYcwnNMCYk19s03pHhVJ9zshOVkqAnTo49hAIPLpH0aADRBsbQhefmGafoiqVPxSSWjmk5DJ+j1GhRuEFx9s+r958yjtgQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585413038; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=W8sqTVEMcyz6GbHdpLb1qcpeRJxeb3CDdvMKIWzOOas=; 
        b=Zq+4ry9R+aoVGlV6RO+Lm+29iaZDpFTJEJ7LjNx/GCPOcDt2D4Uhx5wtsY9qvzTrCCV6JgdxTtvTxFU0qVBmOw10u/6Z064FBbAEBQMulYn0EjfgbWsrVoAhnDB+3SxIXv5wZNyAeX9Rx8NEkN74iEERPFmd140O1/iiijVIcrQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=hurranet.com;
        spf=pass  smtp.mailfrom=aiman.najjar@hurranet.com;
        dmarc=pass header.from=<aiman.najjar@hurranet.com> header.from=<aiman.najjar@hurranet.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585413038;
        s=zoho; d=hurranet.com; i=aiman.najjar@hurranet.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=W8sqTVEMcyz6GbHdpLb1qcpeRJxeb3CDdvMKIWzOOas=;
        b=WacWzqBFOl9ntZYDamCl6mn7PzNqKxPCqsjao9UX3/cVwxIdhlW5P5ETdK/nDsvj
        rcVD1G4+G7V0mUzNl4SNZdCFwLRBIIUCQVvZ12Dg+S0nuKe8T8TlxxKoquOJHxmRpfB
        kE7bfTmu95gM7BOhsnEQ/8UAFKYomKO5D9Sc30q4=
Received: from kernel-dev (097-100-022-132.res.spectrum.com [97.100.22.132]) by mx.zohomail.com
        with SMTPS id 1585413035447344.88702204502886; Sat, 28 Mar 2020 09:30:35 -0700 (PDT)
From:   aimannajjar <aiman.najjar@hurranet.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     aimannajjar <aiman.najjar@hurranet.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Message-ID: <cover.1585353747.git.aiman.najjar@hurranet.com>
Subject: [PATCH v2 0/5] staging: rtl8712: fix rtl871x_xmit.c warnings
Date:   Fri, 27 Mar 2020 20:08:06 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327080429.GB1627562@kroah.com>
References: <20200327080429.GB1627562@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This v2 of the patch breaks up the previous patch into
a patchset of smaller patches.

Overall, the patchset fixes the remaining 9 warnings
in rtl871x_xmit.c.

aimannajjar (5):
  staging: rtl8712: fix checkpatch long-line warning
  staging: rtl8712: fix long-line checkpatch warning
  staging: rtl8712: fix checkpatch warnings
  staging: rtl8712: fix multiline derefernce warning
  staging: rtl8712:fix multiline derefernce warnings

 drivers/staging/rtl8712/rtl871x_xmit.c | 85 +++++++++++++-------------
 1 file changed, 41 insertions(+), 44 deletions(-)

--=20
2.20.1


