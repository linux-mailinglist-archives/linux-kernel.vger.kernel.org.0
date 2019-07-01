Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F352E44C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 20:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfE2SPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 14:15:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42818 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2SPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:15:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TI45Gd026303;
        Wed, 29 May 2019 18:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=X1r1l9IbI3BOkFp9ol61hLAsIPyF/vTaoewLMBFuIz4=;
 b=GCg6eFTfUHhgUB9eSXQA3fJP4YzWZr9DQtM9SwudrdjDKsu/cZFM5ziuaDyOnb5KCu4N
 acONfWg+yW/wZSxYkdi/qKt0ieppowilWMz67EWhfZZtxvmQ687AJn3yvHY8BBaq98p/
 Glc5IO7eW9QIyvJtIVxd9nLNHu2tjqL94oDA5hn2SJS5LTVLX2Vu2GALld7vwzldXvx+
 lVPUbcfN1vjA5J4YPAZNXo+6L6y5NT3YZtnDLVthlDrNwhjboZ1rQzH2N3SWzjl0N7xF
 CwnRPwr9wbd3tSn23Hmvr2Qc5nef13kNRIzztRJ4WXnYpK3C+fSuXsf1cZrGDerjbpdK Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2spw4tkq38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:15:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TIE7Ja160246;
        Wed, 29 May 2019 18:15:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2srbdxj39c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:15:41 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4TIFd4U022602;
        Wed, 29 May 2019 18:15:39 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 11:15:38 -0700
Date:   Wed, 29 May 2019 21:15:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] staging: kpc2000: add missing spaces in core.c
Message-ID: <20190529181532.GM24680@kadam>
References: <20190524110802.2953-1-simon@nikanor.nu>
 <20190524110802.2953-4-simon@nikanor.nu>
 <20190527073159.GX31203@kadam>
 <20190529155419.ego3sfedew65ini5@dev.nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190529155419.ego3sfedew65ini5@dev.nikanor.nu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 05:54:19PM +0200, Simon Sandstr�m wrote:
> On Mon, May 27, 2019 at 10:31:59AM +0300, Dan Carpenter wrote:
> > On Fri, May 24, 2019 at 01:08:01PM +0200, Simon Sandstr�m wrote:
> > > [..]
> > > -		ret = copy_to_user((void*)ioctl_param, (void*)&temp, sizeof(temp));
> > > +		ret = copy_to_user((void *)ioctl_param, (void *)&temp, sizeof(temp));
> > >  		if (ret)
> > >  			return -EFAULT;
> > 
> > This should really be written like so:
> > 
> > 		if (copy_to_user((void __user *)ioctl_param, &temp,
> > 				 sizeof(temp)))
> > 			return -EFAULT;
> > 
> > temp is really the wrong name.  "temp" is for temperatures.  "tmp" means
> > temporary.  But also "tmp" is wrong here because it's not a temporary
> > variable.  It's better to call it "regs" here.
> > 
> > regards,
> > dan carpenter
> > 
> 
> I agree, but I don't think it fits within this patch. I can send a
> separate patch with this change.

You could send the other chunk as a separate patch, but I don't think it
makes sense to apply this chunk when really it just needs to be
re-written.

I normally don't complain too much about mechanical no-thought patches,
but in this case the function is very sub-par and should be re-written.

regards,
dan carpenter
