Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48AA430EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 15:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfEaNcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 09:32:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54010 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaNcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 09:32:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4VDNQYu041473;
        Fri, 31 May 2019 13:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=0Pb+9bAmSfuo0G6M0SFQAFdEYxAVKO5NFrhx83VLndc=;
 b=Eneutn7oWksclz7rOTEvwJAO0C9V/sg1kp88WXETStRZwtT+VkcpRssNKomPSPaLmwFo
 dOLbuwGSlAeXoYl+XCalDCgAkIfD2RLqxR2xanQylWpGTZGlyqdpberAPgs9H+/U5xD+
 F5SAAOVS+kU2BSozbQFtcAtDB6hweWWrMqehPrOTR1tGc46aRI+z7K39eHUqLybZv3xb
 PaVD2cVW4ka8/+Uj1dxhA2I6VRtw3bAnkVoSk9GGIfRwc59tqhgBwqhlZyOdjF3fbR0f
 3Mgxw6LL8R+cGjGRaMjk+rMGaP66IEPdxMh7r+u4Eg/onUT13JopTLIjUEW1dQ902lUy bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2spw4tx8jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 13:31:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4VDTvZF101097;
        Fri, 31 May 2019 13:31:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2su3y497kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 13:31:39 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4VDVWQf013237;
        Fri, 31 May 2019 13:31:32 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 May 2019 06:31:32 -0700
Date:   Fri, 31 May 2019 16:31:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     Ian Abbott <abbotti@mev.co.uk>, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org, olsonse@umich.edu, jkhasdev@gmail.com,
        giulio.benetti@micronovasrl.com, nishadkamdar@gmail.com,
        kas.sandesh@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: Remove variable runflags
Message-ID: <20190531133122.GF31203@kadam>
References: <20190530205131.29955-1-nishkadg.linux@gmail.com>
 <8292224d-9c4a-d29e-4a86-d3352fcd2be1@mev.co.uk>
 <ceb54997-3057-81df-f3f0-e04b36e950c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb54997-3057-81df-f3f0-e04b36e950c4@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=806
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905310086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=860 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905310086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anyway, Greg was never going to apply this so it's not worth worrying
about too much.

regards,
dan carpenter

