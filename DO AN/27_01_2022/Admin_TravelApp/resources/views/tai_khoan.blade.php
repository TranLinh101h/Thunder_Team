@extends('layouts.layout_admin')
@section('content')
<!-- Page Header -->
            <div class="page-header row no-gutters py-4">
              <div class="col-12 col-sm-4 text-center text-sm-left mb-0">
                <h3 class="page-title">Danh Sách Tài Khoản</h3>
              </div>
            </div>
            <!-- End Page Header -->
            
            <!-- Default Dark Table -->
            <div class="row">
              <div class="col">
                <div class="card card-small overflow-hidden mb-4">
                  <div class="card-header bg-dark">
                    <h6 class="m-0 text-white">Inactive Users</h6>
                  </div>
                  <div class="card-body p-0 pb-3 bg-dark text-center">
                    <table class="table table-dark mb-0">
                      <thead class="thead-dark">
                        <tr>
                          <th scope="col" class="border-bottom-0">#</th>
                          <th scope="col" class="border-bottom-0">First Name</th>
                          <th scope="col" class="border-bottom-0">Last Name</th>
                          <th scope="col" class="border-bottom-0">Country</th>
                          <th scope="col" class="border-bottom-0">City</th>
                          <th scope="col" class="border-bottom-0">Phone</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>1</td>
                          <td>Graham</td>
                          <td>Brent</td>
                          <td>Benin</td>
                          <td>Ripabottoni</td>
                          <td>1-512-760-9094</td>
                        </tr>
                        <tr>
                          <td>2</td>
                          <td>Clark</td>
                          <td>Angela</td>
                          <td>Estonia</td>
                          <td>Borghetto di Vara</td>
                          <td>1-660-850-1647</td>
                        </tr>
                        <tr>
                          <td>3</td>
                          <td>Wylie</td>
                          <td>Joseph</td>
                          <td>Korea, North</td>
                          <td>Guelph</td>
                          <td>325-4351</td>
                        </tr>
                        <tr>
                          <td>4</td>
                          <td>Garth</td>
                          <td>Clementine</td>
                          <td>Indonesia</td>
                          <td>Narcao</td>
                          <td>722-8264</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
            <!-- End Default Dark Table -->
          </div>
@endsection