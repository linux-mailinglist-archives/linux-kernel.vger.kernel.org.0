Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 098DFE1C54
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 15:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405767AbfJWNWb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Oct 2019 09:22:31 -0400
Received: from nemx1.ne.ch ([148.196.30.16]:56858 "EHLO nemx1.ne.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405266AbfJWNWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:22:31 -0400
X-Greylist: delayed 20580 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Oct 2019 09:22:29 EDT
Received: from rpnedge1.rpn.ch ([157.26.1.37])
        by nemx1.ne.ch with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <Susanne.Nussbaum@rpn.ch>)
        id 1iNBDy-00084k-FN; Wed, 23 Oct 2019 09:38:33 +0200
Received: from rpncmbx4.rpn.ch (157.26.0.38) by RPNEDGE1.rpn.ch (157.26.1.37)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Wed, 23 Oct
 2019 09:37:36 +0200
Received: from rpncmbx4.rpn.ch (157.26.0.38) by rpncmbx4.rpn.ch (157.26.0.38)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 09:37:35 +0200
Received: from rpncmbx4.rpn.ch ([10.26.1.38]) by rpncmbx4.rpn.ch
 ([10.26.1.38]) with mapi id 15.01.1713.009; Wed, 23 Oct 2019 09:37:35 +0200
From:   Nussbaum Susanne <Susanne.Nussbaum@rpn.ch>
To:     "No-reply@microsoft.net" <No-reply@microsoft.net>
Subject: 20 of your incoming messages has been suspended 
Thread-Topic: 20 of your incoming messages has been suspended 
Thread-Index: AQHViXS8lBL5CLFtMUK5MKHVDLX3sw==
Date:   Wed, 23 Oct 2019 07:37:35 +0000
Message-ID: <c2fe0e3962cb4f68befbf4aa1525cfbc@rpn.ch>
Accept-Language: fr-CH, en-US
Content-Language: fr-CH
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [157.26.1.46]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Originating-IP: 157.26.1.37
X-EtatdeNeuchatel-Domain: rpn.ch
X-EtatdeNeuchatel-Username: 157.26.1.37
Authentication-Results: ne.ch; auth=pass smtp.auth=157.26.1.37@rpn.ch
X-EtatdeNeuchatel-Outgoing-Class: ham
X-EtatdeNeuchatel-Outgoing-Evidence: Combined (0.50)
X-Recommended-Action: accept
X-Filter-ID: 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
 BSmZBoVt2x2Uh1UwcBJN+Ui9xg==
X-Report-Abuse-To: spam@nemx1.ne.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MICROSOFT URGENT NOTICE

20 of your incoming messages has been suspended because your email box account needs to be verify now.Do click on the verify below to verify your email box account now.


VERIFY<http://de43e.000webhostapp.com/>


Microsoft Verification Team


Copyright © 2019 Microsoft .Inc . All rights reserved.


